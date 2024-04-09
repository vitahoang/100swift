//
//  DurationHourMinutePickerView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/8/24.
//

import SwiftUI

struct DurationHourMinutePickerView: View {
    @Binding var durationHour: Int
    @Binding var durationMinute: Int
    @Binding var endTime: Date
    @Binding var startTime: Date

    var body: some View {
        HStack {
            Text("Duration")
            Spacer()
            HStack {
                Text("hour")
                    .bold()
                    .italic()
                    .font(.caption)
                Picker("hour", selection: $durationHour) {
                    ForEach(0 ... 24, id: \.self) {
                        Text("\($0)")
                    }
                }
                .tag("durationHour")
                .pickerStyle(.menu)
                .tint(.primary)
                .frame(minWidth: 70)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 7, height: 7)))
                .onChange(of: durationHour) {
                    updateStartEndTime()
                }
            }
            HStack {
                Text("min")
                    .bold()
                    .italic()
                    .font(.caption)
                    .frame(minWidth: 20)
                Picker("min", selection: $durationMinute) {
                    ForEach((0 ... 55).filter { ($0 % 5) == 0 }, id: \.self) {
                        Text("\($0)")
                    }
                }
                .tag("durationMin")
                .pickerStyle(.menu)
                .tint(.primary)
                .frame(minWidth: 70)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 7, height: 7)))
                .onChange(of: durationMinute) {
                    updateStartEndTime()
                }
            }
        }
    }

    func updateStartEndTime() {
        let interval = Double(durationHour*3600) + Double(durationMinute*60)
        endTime = Date(timeInterval: interval, since: startTime)
    }
}

#Preview {
    DurationHourMinutePickerView(durationHour: .constant(0), durationMinute: .constant(0), endTime: .constant(Date()), startTime: .constant(Date()))
}
