//
//  Card.swift
//  Edutainment
//
//  Created by Vita Hoang on 4/3/24.
//

import Foundation
import SwiftUI

struct CardStack<Content: View>: View {
    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        HStack(content: self.content)
            .padding()
            .ignoresSafeArea()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.15), radius: 3)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
    }
}

extension View {
    func cardView() -> some View {
        self
            .ignoresSafeArea()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.15), radius: 3)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
    }
}
