//
//  ViewModel.swift
//  SoundWave
//
//  Created by Bastien Falcou on 12/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

class SoundRecord {
    
    var audioFilePathLocal: URL?
    var meteringLevels: [Float]?
    
    init(audioFilePathLocal: URL? = nil, meteringLevels: [Float]? = nil) {
        self.audioFilePathLocal = audioFilePathLocal
        self.meteringLevels = meteringLevels
    }
}

final class ViewModel {
    
    static let shared = ViewModel()
    
    var audioVisualizationTimeInterval: TimeInterval = 0.05 // Time interval between each metering bar representation

    var currentAudioRecord: SoundRecord?
    private var isPlaying = false

    var audioMeteringLevelUpdate: ((Float) -> ())?
    var audioDidFinish: (() -> ())?

    init() {
        // notifications update metering levels
        NotificationCenter.default.addObserver(self, selector: #selector(ViewModel.didReceiveMeteringLevelUpdate), name: .audioPlayerManagerMeteringLevelDidUpdateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewModel.didReceiveMeteringLevelUpdate), name: .audioRecorderManagerMeteringLevelDidUpdateNotification, object: nil)

        // notifications audio finished
        NotificationCenter.default.addObserver(self, selector: #selector(ViewModel.didFinishRecordOrPlayAudio), name: .audioPlayerManagerMeteringLevelDidFinishNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewModel.didFinishRecordOrPlayAudio), name: .audioRecorderManagerMeteringLevelDidFinishNotification, object: nil)
    }

    // MARK: - Recording

    func askAudioRecordingPermission(completion: ((Bool) -> Void)? = nil) {
        return AudioRecorderManager.shared.askPermission(completion: completion)
    }

    func startRecording(completion: @escaping (SoundRecord?, Error?) -> Void) {
        AudioRecorderManager.shared.startRecording(with: self.audioVisualizationTimeInterval, completion: { [weak self] url, error in
            guard let url = url else {
                completion(nil, error!)
                return
            }

            self?.currentAudioRecord = SoundRecord(audioFilePathLocal: url, meteringLevels: [])
            print("sound record created at url \(url.absoluteString))")
            completion(self?.currentAudioRecord, nil)
        })
    }

    func stopRecording() throws {
        try AudioRecorderManager.shared.stopRecording()
    }

    func resetRecording() throws {
        try AudioRecorderManager.shared.reset()
        self.isPlaying = false
        self.currentAudioRecord = nil
    }

    // MARK: - Playing

    func startPlaying(url: String, completion: @escaping (TimeInterval) -> Void) throws {
        guard let currentAudioRecord = URL(string: url) else {
            throw AudioErrorType.audioFileWrongPath
        }

        if self.isPlaying {
            completion(try AudioPlayerManager.shared.resume())
        } else {
            self.isPlaying = true
            print("url:", url)
            
//            try FileDownloader.loadFileAsync(url: currentAudioRecord) { localURL, error in
//                if let error = error {
//                    print("Failed to load file Async:", error)
//                    return
//                }
//                print("AUDIO File downloaded to : \(localURL!)")
//                completion(23.5)
//
//                let data = try Data(contentsOf: URL(string: url)!, options: .mappedIfSafe)
//                return try AudioPlayerManager.shared.play(data, with: self.audioVisualizationTimeInterval)
//                let data = try Data(contentsOf: URL(string: url)!, options: .mappedIfSafe)
//            }
            //                completion(try AudioPlayerManager.shared.play(data, with: self.audioVisualizationTimeInterval))
            
            FileDownloader.loadFileAsync(url: currentAudioRecord) { localURL, error in
                if let error = error {
                    print("Failed to load file Async:", error)
                    return
                }
                print("AUDIO File downloaded to : \(localURL!)")
                let data = try Data(contentsOf: URL(string: url)!, options: .mappedIfSafe)
                completion(try AudioPlayerManager.shared.play(data, with: self.audioVisualizationTimeInterval))
            }
        }
    }
    
    func startPlaying() throws -> TimeInterval {
        guard let currentAudioRecord = self.currentAudioRecord else {
            throw AudioErrorType.audioFileWrongPath
        }

        if self.isPlaying {
            return try AudioPlayerManager.shared.resume()
        } else {
            guard let audioFilePath = currentAudioRecord.audioFilePathLocal else {
                fatalError("tried to unwrap audio file path that is nil")
            }

            self.isPlaying = true
            return try AudioPlayerManager.shared.play(at: audioFilePath, with: self.audioVisualizationTimeInterval)
        }
    }

    func pausePlaying() throws {
        try AudioPlayerManager.shared.pause()
    }

    // MARK: - Notifications Handling

    @objc private func didReceiveMeteringLevelUpdate(_ notification: Notification) {
        let percentage = notification.userInfo![audioPercentageUserInfoKey] as! Float
        self.audioMeteringLevelUpdate?(percentage)
    }

    @objc private func didFinishRecordOrPlayAudio(_ notification: Notification) {
        self.audioDidFinish?()
    }
}
