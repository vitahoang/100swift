//
//  EditKeyboardToolBarView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/8/24.
//

import SwiftUI

struct EditKeyboardToolBarView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @Binding var habitName: String
    @Binding var habitDescription: String
    @Binding var dayOfWeek: String
    @Binding var habitIcon: Emoji
    var body: some View {
        Spacer()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    if !habitName.isEmpty {
                        HStack {
                            Spacer()
                            Button("Add") {
                                let habit = Habit(emoji: habitName, name: habitDescription, description: habitIcon.value, dayOfWeek: dayOfWeek)
                                modelContext.insert(habit)
                                dismiss()
                            }
                            .padding(3)
                            .background(.primary)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)), style: FillStyle())
                        }
                    }
                }
            }
    }
}

#Preview {
    EditKeyboardToolBarView(habitName: .constant("Test"), habitDescription: .constant("Test"), dayOfWeek: .constant("Test"), habitIcon: .constant(EmojiList().emojiList[0]))
}
