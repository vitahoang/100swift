//
//  BlurBackgroundView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/7/24.
//

import SwiftUI

struct BlurBackgroundView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

#Preview {
    BlurBackgroundView(effect: UIBlurEffect(style: .dark))
        .ignoresSafeArea()
}
