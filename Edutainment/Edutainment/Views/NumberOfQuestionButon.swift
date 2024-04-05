//
//  Button.swift
//  Edutainment
//
//  Created by Vita Hoang on 4/4/24.
//

import SwiftUI

struct NumberOfQuestionButon: View {
    var content: String
    
    init(_ content: String) {
        self.content = content
    }
    
    var body: some View {
        Text(content)
            .padding(5)
            .frame(maxWidth: 40)
            .background(Gradient(colors: [.blue]))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
    }
}

#Preview {
    NumberOfQuestionButon("Test")
}
