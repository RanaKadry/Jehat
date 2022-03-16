//
//  SoundWavesView.swift
//  Recorder
//
//  Created by Peter Bassem on 07/10/2021.
//

import UIKit
import SoundWave

@IBDesignable
class SoundWavesView: AudioVisualizationView {
    
    enum AudioRecodingState {
        case ready             // - > hide
        case recording             // - > hide
        case recorded             // - > show
        case playing             // - > hide
        case paused             // - > show

        var buttonImage: UIImage {
            switch self {
            case .ready, .recording:
                return DesignSystem.Icon.recordButton.image
            case .recorded, .paused:
                return DesignSystem.Icon.playButton.image
            case .playing:
                return DesignSystem.Icon.pauseButton.image
            }
        }

        var audioVisualizationMode: AudioVisualizationView.AudioVisualizationMode {
            switch self {
            case .ready, .recording:
                return .write
            case .paused, .playing, .recorded:
                return .read
            }
        }
    }

    // MARK: - Variables
    @IBInspectable
    var startColor: UIColor? {
        didSet { configure() }
    }
    @IBInspectable
    var endColor: UIColor? {
        didSet { configure() }
    }
    
    
    private var chronometer: Chronometer?
    private let viewModel = ViewModel()
    var currentState: AudioRecodingState = .ready {
        didSet {
            audioVisualizationMode = self.currentState.audioVisualizationMode
            updateButtonImage?(currentState)
            if currentState == .paused || currentState == .recorded {
                showResetButton?()
            } else {
                hideResetButton?()
            }
        }
    }
    var updateButtonImage: ((AudioRecodingState) -> Void)?
    var showResetButton:(() -> Void)?
    var hideResetButton:(() -> Void)?
    private(set) var recordURL: URL?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Private Configuration
    private func configure() {
        gradientStartColor = startColor ?? .white
        gradientEndColor = endColor ?? .black
        configureViewModel()
        if LocalizationHelper.isArabic() {
            transform = .init(scaleX: -1, y: 1)
        }
    }
    
    private func configureViewModel() {
        viewModel.askAudioRecordingPermission()
        
        viewModel.audioMeteringLevelUpdate = { [weak self] meteringLevel in
            guard let self = self, self.audioVisualizationMode == .write else {
                return
            }
            self.add(meteringLevel: meteringLevel)
        }
        
        viewModel.audioDidFinish = { [weak self] in
            self?.currentState = .recorded
            self?.stop()
        }
    }
    
    // MARK: - Recording Helpers
    func startRecording() {
        if currentState == .ready {
            viewModel.startRecording { [weak self] soundRecord, error in
                if let error = error {
                    print("Failed to start recording:", error)
                    return
                }
                self?.recordURL = soundRecord?.audioFilePathLocal?.absoluteURL
                self?.currentState = .recording
                self?.chronometer = Chronometer()
                self?.chronometer?.start()
            }
        }
    }
    
    func stopRecording() {
        chronometer?.stop()
        chronometer = nil
        
        self.viewModel.currentAudioRecord!.meteringLevels = scaleSoundDataToFitScreen()
        audioVisualizationMode = .read
        
        do {
            try viewModel.stopRecording()
            currentState = .recorded
        } catch let error {
            print("Failed to stop recording:", error)
            currentState = .ready
        }
    }
    
    // MARK: - Playing Helpers
    func playRecord(withUrl url: String) {
        do {
            currentState = .recording
            try viewModel.startPlaying(url: url, completion: { [weak self] duration in
                self?.currentState = .playing
                self?.meteringLevels = [] // viewModel.currentAudioRecord!.meteringLevels
                for _ in stride(from: 0, to: duration, by: Double.Stride(1)) {
                    self?.meteringLevels?.append(Float.random(min: 0, max: 1))
                }
                if self?.meteringLevels != nil {
                    self?.play(for: duration)
                } else {
                    print("meteringLevels is nil")
                }
            })
        } catch let error {
            print("Failed to play Recording:", error)
        }
    }
    
    func pausePlayingRecord() {
        do {
            try viewModel.pausePlaying()
            currentState = .paused
            pause()
        } catch let error {
            print("Failed to pause Audio:", error)
        }
    }
    
    func play() throws {
        let duration = try viewModel.startPlaying()
        currentState = .playing
        meteringLevels = viewModel.currentAudioRecord!.meteringLevels
        play(for: duration)
    }
    
    func pausePlaying() throws {
        try viewModel.pausePlaying()
        currentState = .paused
        pause()
    }
    
    func resetRecord() throws {
        try viewModel.resetRecording()
        reset()
        currentState = .ready
    }
}
