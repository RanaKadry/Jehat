//
//  AddVoiceNoteViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 13/10/2021.
//

import UIKit

final class AddVoiceNoteViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var blurVisualEffectView: UIVisualEffectView!
    @IBOutlet private weak var containerView: UIView! {
        didSet  { containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] }
    }
    @IBOutlet private weak var commentTextView: PlaceholderTextView!
    @IBOutlet private weak var audioVisualizationView: SoundWavesView!
    @IBOutlet private weak var recordButton: UIButton!
    @IBOutlet private weak var saveButton: SpinnerButton!
    @IBOutlet private weak var resetButton: UIButton!
    
    // MARK: - Variables
    var presenter: AddVoiceNotePresenterProtocol!
    
    private lazy var tapGesture: TapGestureRecognizer = {
        let gestureRecognizer = TapGestureRecognizer(target: self, action: #selector(tapGestureDidPressed(_:)))
        return gestureRecognizer
    }()
    
    var _saveButton: SpinnerButton {
        return saveButton
    }
    var _resetButton: UIButton {
        return resetButton
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        blurVisualEffectView.addGestureRecognizer(tapGesture)
        configureAudioVisualizationView()
    }
}

// MARK: - Helpers
extension AddVoiceNoteViewController {
    
    private func configureAudioVisualizationView() {
        audioVisualizationView.updateButtonImage = { [weak self] currentState in
            self?.recordButton.setImage(currentState.buttonImage, for: .normal)
        }
        
        audioVisualizationView.hideResetButton = { [weak self] in
            self?.presenter.performHideResetButton()
        }
        
        audioVisualizationView.showResetButton = { [weak self] in
            self?.presenter.performShowResetButton()
        }
    }
}

// MARK: - Selectors
extension AddVoiceNoteViewController {
    
    @objc
    private func tapGestureDidPressed(_ sender: UITapGestureRecognizer) {
        presenter.performBack()
    }
    
    @IBAction
    private func recordButtonDidTouchDown(_ sender: UIButton) {
        audioVisualizationView.startRecording()
    }
    
    @IBAction
    private func recordButtonDidTouchUpInside(_ sender: UIButton) {
        switch audioVisualizationView.currentState {
        case .recording:
            audioVisualizationView.stopRecording()
            presenter.performFinishRecording()
        case .recorded, .paused:
            do {
                try audioVisualizationView.play()
            } catch let error {
                print("Failed to play record:", error)
            }
        case .playing:
            do {
                try audioVisualizationView.pausePlaying()
            } catch let error {
                print("Failed to play record:", error)
            }
        default: break
        }
    }
    
    @IBAction
    private func cancelButtonDidPressed(_ sender: UIButton) {
        presenter.performCancelButton()
    }
    
    @IBAction
    private func saveButtonDidPressed(_ sender: SpinnerButton) {
//        print("Record Data:", audioVisualizationView.recordURL?.dataRepresentation)
        presenter.performSaveButton(comment: commentTextView.text, audioURL: audioVisualizationView.recordURL)
    }
    
    @IBAction
    private func resetButtonDidPressed(_ sender: UIButton) {
        do {
            try audioVisualizationView.resetRecord()
            presenter.performResetRecording()
        } catch let error {
            print("Failed to reset record:", error)
        }
    }
}
