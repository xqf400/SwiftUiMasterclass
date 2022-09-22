//
//  PlaySound.swift
//  Slots
//
//  Created by Fabian Kuschke on 22.09.22.
//

import AVFoundation


var audioPlayer: AVAudioPlayer?


func playSound(sound:String, type: String){
    let activateSound = UserDefaults.standard.bool(forKey: "activateSound")
        if activateSound {
            if let path = Bundle.main.path(forResource: sound, ofType: type) {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    audioPlayer?.play()
                }catch{
                    print("Could not load \(sound)")
                }
            }
        }
}

