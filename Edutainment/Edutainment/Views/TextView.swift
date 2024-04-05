//
//  FontView.swift
//  Edutainment
//
//  Created by Vita Hoang on 4/3/24.
//

import Foundation
import SwiftUI

struct Headline: View {
    var content: String
    
    init(_ content: String) {
        self.content = content
    }
    
    var body: some View {
        Text(content)
            .font(.headline)
    }
}

struct Title2: View {
    var content: String
    
    init(_ content: String) {
        self.content = content
    }
    
    var body: some View {
        Text(content)
            .foregroundStyle(.white)
            .font(.title2)
            .bold()
            .padding()
    }
}

struct QuestionText: View {
    @Binding var content: String
    
    var body: some View {
        Text(content)
            .foregroundStyle(.white)
            .font(.title)
            .bold()
            .padding()
    }
}
