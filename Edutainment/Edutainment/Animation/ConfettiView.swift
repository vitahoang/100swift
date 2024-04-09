//
//  Confetti.swift
//  Edutainment
//
//  Created by Vita Hoang on 4/4/24.
//

import Lottie
import SwiftUI

struct ConfettiView: View {
    @Binding var didFinish: Bool
    @State private var playbackMode = LottiePlaybackMode.playing(.toProgress(1, loopMode: .playOnce))
    var playLoopMode: LottieLoopMode = .playOnce
    var confettiFileList = ["confetti-1", "confetti-2"]

    var body: some View {
        LottieView(animation: .named(confettiFileList.randomElement() ?? "confetti-1"))
        .configure { LottieAnimationView in
            LottieAnimationView.contentMode = .scaleAspectFit
        }
        .playbackMode(playbackMode)
        .animationSpeed(1.5)
        .animationDidFinish { _ in
            didFinish = false
        }
        .resizable()
        .ignoresSafeArea()
    }
}

#Preview {
    ConfettiView(didFinish: .constant(true))
}
