//
//  StartQuestion.swift
//  Edutainment
//
//  Created by Vita Hoang on 4/4/24.
//

import SwiftUI

struct StartButton: View {
    var content: String
    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .frame(width: 200, height: 50)
            .background(Gradient(colors: [.white]))
            .foregroundColor(.blue)
            .font(.headline)
            .cornerRadius(10)
            .shadow(color: .white, radius: 5)
    }
}

#Preview {
    ZStack {
        BlueGradient()
        StartButton("Test")
    }.ignoresSafeArea()
}
