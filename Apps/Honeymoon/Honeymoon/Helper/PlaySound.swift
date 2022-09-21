//
//  PlaySound.swift
//  Honeymoon
//
//  Created by Fabian Kuschke on 14.09.22.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?
let playSound = false

func playSound(sound: String, type:String){
    if playSound{
        if let path = Bundle.main.path(forResource: sound, ofType: type){
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            }catch{
                print("error playing sound")
            }
        }else{
            print("not found")
        }
    }
}
