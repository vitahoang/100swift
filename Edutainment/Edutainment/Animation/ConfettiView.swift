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

    var body: some View {
        LottieView(animation: .named("confetti"))
        .configure { LottieAnimationView in
            LottieAnimationView.contentMode = .scaleAspectFit
        }
        .playbackMode(playbackMode)
        .animationDidFinish { _ in
            didFinish = false
        }
    }
}

#Preview {
    ConfettiView(didFinish: Preview.$finish)
}
