//
//  AddTaskView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/6/24.
//

import Smile
import SwiftUI

struct AddTaskView: View {
    @Environment(\.modelContext) var modelContext
    var localeWeekday = DateFormatter().weekdaySymbols!
    @State private var dayOfWeek = "Monday"
    @State private var habitName = ""
    @State private var habitIcon = EmojiList().emojiList[0]
    @State private var habitDescription = ""
    @State private var habitCount = 0
    @State private var searchEmoji = ""
    @State private var searchPresented = true

    @State private var startTime = Date()
    @State private var endTime = Date()

    @State private var durationHour = 0
    @State private var durationMinute = 0

    @FocusState var focusedField: FocusedField?

    var body: some View {
        NavigationStack {
            TaskTiltleView(focusedField: $focusedField, habitName: $habitName)

            ZStack {
                VStack {
                    HStack {
                        if habitDescription.isEmpty {
                            Text("Describe your task")
                                .font(.callout)
                                .italic()
                                .foregroundStyle(.placeholder)
                                .padding(.top, 20)
                                .padding(.leading, 5)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                TextEditor(text: $habitDescription)
                    .textEditorStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(.primary)
                    .padding(.top, 10)
                    .focused($focusedField, equals: .description)
            }
            .frame(maxHeight: 60)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)), style: FillStyle())

            Picker("Day", selection: $dayOfWeek) {
                ForEach(localeWeekday, id: \.self) { day in
                    Text(String(day))
                }
            }

            StartEndTimePickerView(startTime: $startTime, endTime: $endTime, durationHour: $durationHour, durationMinute: $durationMinute)
            DurationHourMinutePickerView(durationHour: $durationHour, durationMinute: $durationMinute, endTime: $endTime, startTime: $startTime)
            EditKeyboardToolBarView(habitName: $habitName, habitDescription: $habitDescription, dayOfWeek: $dayOfWeek, habitIcon: $habitIcon)
        }
        .preferredColorScheme(.dark)
        .padding(10)
        .onAppear {
            focusedField = .name
        }
    }
}

#Preview {
    AddTaskView()
}

