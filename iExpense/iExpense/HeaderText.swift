//
//  HeaderText.swift
//  iExpense
//
//  Created by Vita Hoang on 4/5/24.
//

import SwiftUI

struct HeaderText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title2)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 10)
    }
}

#Preview {
    HeaderText(text: "Test")
}
