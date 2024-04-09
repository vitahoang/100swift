//
//  TaskTiltleView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/7/24.
//

import SwiftUI

    struct TaskTiltleView: View {
    var focusedField: FocusState<FocusedField?>.Binding
    @State private var habitIcon = EmojiList().emojiList[0]
    @State private var showEmojiPicker = false
    @Binding var habitName: String
    @State private var selectedColor = Color(.gray)

    var body: some View {
        HStack {
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill((Color.gray).opacity(0.4))
                    .frame(width: 35, height: 35)
                    .overlay {
                        Text(habitIcon.value)
                            .font(.title3)
                    }
                    .onTapGesture {
                        showEmojiPicker = true
                    }
                    .focused(focusedField, equals: FocusedField.icon)
                TextField("Name", text: $habitName)
                    .font(.title3)
                    .bold()
                    .focused(focusedField, equals: .name)
            }
            Spacer()
        }
        .sheet(isPresented: $showEmojiPicker) {
            NavigationView {
                EmojiPickerView(selectedEmoji: $habitIcon, selectedColor: selectedColor)
            }
            .navigationTitle("Emojis")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct WrapView: View {
    @State private var habitName = "Example"
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        TaskTiltleView(focusedField: $focusedField, habitName: $habitName)
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WrapView()
    }
}
