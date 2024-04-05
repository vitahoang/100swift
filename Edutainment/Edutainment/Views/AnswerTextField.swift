//
//  AnswerTextField.swift
//  Edutainment
//
//  Created by Vita Hoang on 4/4/24.
//

import SwiftUI

struct AnswerTextField: View {
    var title: String
    @Binding var text: String
    var error: String
    var body: some View {
        VStack {
            TextField(title, text: $text)
                .padding(20)
                .keyboardType(.numberPad)
                .frame(height: 40)
                .background(.white)
                .cornerRadius(10)
            HStack {
                Text(error)
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
                    .padding(.top, 5)
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    ZStack {
        Color(.black)
            .ignoresSafeArea()
        AnswerTextField(title: Preview.title, text: Preview.$text, error: Preview.error)
    }
}
