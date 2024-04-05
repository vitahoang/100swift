//
//  MissionViewTitle.swift
//  MoonShoot
//
//  Created by Vita Hoang on 4/5/24.
//

import SwiftUI

struct MissionViewTitle: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title.bold())
            .padding(.bottom, 5)
    }
}

#Preview {
    MissionViewTitle(text: "test")
}
