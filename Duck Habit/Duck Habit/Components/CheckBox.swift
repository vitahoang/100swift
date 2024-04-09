//
//  CheckBox.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/6/24.
//

import SwiftUI

struct CheckBoxView: View {
    @State var isChecked: Bool

    var body: some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .onTapGesture {
                self.isChecked.toggle()
            }
            .foregroundColor(.white)
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    struct CheckBoxViewHolder: View {
        @State var checked = false

        var body: some View {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                CheckBoxView(isChecked: checked)
            }
        }
    }

    static var previews: some View {
        CheckBoxViewHolder()
    }
}
