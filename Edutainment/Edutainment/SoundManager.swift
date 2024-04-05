//
//  SoundManager.swift
//  Edutainment
//
//  Created by Vita Hoang on 4/4/24.
//

import AVKit
import SwiftUI

class SoundManager {
    var resource: String
    var player: AVAudioPlayer?

    init(resource: String) {
        self.resource = resource
        if let url = Bundle.main.path(forResource: resource, ofType: "mp3") {
            do {
                self.player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
            } catch {
                print("AVAudioPlayer could not be instantiated.")
            }
        } else {
            print("Audio file could not be found.")
        }
    }

    func playSound() {
        self.player?.play()
    }
}

struct SoundPlayer: View {
    var body: some View {
        Button {
            SoundManager(resource: "success").playSound()
        } label: {
            Text("Play")
        }
    }
}

#Preview {
    SoundPlayer()
}
