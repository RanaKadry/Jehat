//
//  Player.swift
//  SO 49204823
//
//  Created by acyrman on 11/13/18.
//  Copyright © 2018 iCyrman. All rights reserved.
//

import Foundation
import AVFoundation

class Player {
    static var shared = Player()
    var player: AVPlayer?
    var song: URL?
    
    init() {
        song = nil
    }
    
    var audioCompletion: ActionCompletion?
    
    func currentlyPlaying() -> URL? {
        return song
    }
    
    func play(this song: URL) {
        stop()
        do {
//            guard let url = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else { return }
            //try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            let playerItem = AVPlayerItem(url: song)
            
            player = AVPlayer(playerItem: playerItem)
            player?.volume = 1.0
            player?.play()
            self.song = song
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stop() {
        player?.replaceCurrentItem(with: nil)
        self.song = nil
    }
    
    @objc
    private func playerDidFinishPlaying(_ sender: Notification) {
        audioCompletion?()
    }
}
