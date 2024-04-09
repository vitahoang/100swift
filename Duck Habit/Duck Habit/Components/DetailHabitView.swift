//
//  DetailHabitView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/8/24.
//

import SwiftUI

struct DetailHabitView: View {
    var localeWeekday = DateFormatter().weekdaySymbols!
    @State var habit: Habit
    @State var name = ""
    @State var _description = ""
    @State var isChecked = false
    @State var emoji = ""
    @State var dayOfWeek = ""

    @State var searchEmoji = true
    @State var searchPresented = true

    @State var startTime = Date()
    @State var endTime = Date()

    @State var durationHour = 0
    @State var durationMinute = 0

    @FocusState var focusedField: FocusedField?

    var body: some View {
        NavigationStack {
            TaskTiltleView(focusedField: $focusedField, habitName: $name)

            ZStack {
                VStack {
                    HStack {
                        if _description.isEmpty {
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
                TextEditor(text: $habit._description)
                    .textEditorStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(.primary)
                    .padding(.top, 10)
                    .focused($focusedField, equals: .description)
            }
            .frame(maxHeight: 60)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)), style: FillStyle())

            Picker("Day", selection: $habit.dayOfWeek) {
                ForEach(localeWeekday, id: \.self) { day in
                    Text(String(day))
                }
            }
            .tag("dayOfWeek")

            StartEndTimePickerView(startTime: $startTime, endTime: $endTime, durationHour: $durationHour, durationMinute: $durationMinute)
            DurationHourMinutePickerView(durationHour: $durationHour, durationMinute: $durationMinute, endTime: $endTime, startTime: $startTime)
            Spacer()
        }
        .preferredColorScheme(.dark)
        .padding(10)
        .onDisappear {
            habit.name = name
            habit.emoji = emoji
            habit._description = _description
            habit.isChecked = isChecked
            habit.dayOfWeek = dayOfWeek
        }
        .onAppear {
            name = habit.name
            emoji = habit.emoji
            _description = habit._description
            isChecked = habit.isChecked
            dayOfWeek = habit.dayOfWeek
        }
    }
}

#Preview {
    DetailHabitView(habit: Demo.habits[0])
}
