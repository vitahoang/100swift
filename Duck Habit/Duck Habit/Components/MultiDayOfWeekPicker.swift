//
//  MultiDayOfWeekPicker.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/7/24.
//

import SwiftUI

struct MultiDayOfWeekPicker: View {
    var localeWeekday = DateFormatter().weekdaySymbols!
    @State var selectedDayOfWeek = "Monday"
    @State var selectedList: [String] = []
    @Binding var dayOfWeek: Set<String>


    var body: some View {
        Picker("Day", selection: $selectedDayOfWeek) {
            ForEach(localeWeekday, id: \.self) { day in
                Text(String(day))
            }
        }
        .onChange(of: selectedDayOfWeek) {
            selectedList.append(selectedDayOfWeek)
            print(selectedList)
        }
        ForEach($selectedList, id:\.self) { item in
            Text(item.wrappedValue)
        }
    }
}

#Preview {
    MultiDayOfWeekPicker(dayOfWeek: .constant(["Monday"]))
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
