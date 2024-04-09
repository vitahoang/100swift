//
//  StartEndTimePickerView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/8/24.
//

import SwiftUI

struct StartEndTimePickerView: View {
    @Binding var startTime: Date
    @Binding var endTime: Date
    @Binding var durationHour: Int
    @Binding var durationMinute: Int

    var body: some View {
        HStack {
            Text("Time")
            Spacer()
            Text("from")
                .bold()
                .italic()
                .font(.caption)
                .frame(minWidth: 20)
            DatePicker("Time", selection: $startTime, displayedComponents: [.hourAndMinute])
                .labelsHidden()
                .onChange(of: startTime) {
                    updateEndTime()
                    updateDurationTime()
                }.tag("startTime")

            Text("to")
                .bold()
                .italic()
                .font(.caption)
                .frame(minWidth: 20)
            DatePicker("-", selection: $endTime, in: startTime..., displayedComponents: [.hourAndMinute])
                .labelsHidden()
                .onChange(of: endTime) {
                    updateDurationTime()
                }.tag("endTime")
        }
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 5
        }
    }
    func updateEndTime() {
        if startTime > endTime {
            endTime = startTime.advanced(by: 300.0)
        }
    }

    func updateDurationTime() {
        let interval = Int(startTime.distance(to: endTime))
        durationHour = interval / 3600
        durationMinute = (interval % 3600) / 60
    }
}

#Preview {
    StartEndTimePickerView(startTime: .constant(Date()), endTime: .constant(Date()), durationHour: .constant(0), durationMinute: .constant(0))
}
