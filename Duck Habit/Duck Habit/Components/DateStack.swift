//
//  DatesView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/5/24.
//

import SwiftUI

struct DateStack: View {
    private var dates = ["MON": "05", "TUE": "05", "WED": "05", "THU": "05", "FRI": "05", "SAT": "05", "SUN": "05"]
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<dates.count, id: \.self) { day in
                    DateElement()
                }
            }
            .padding(.vertical, 10)
        }
    }
}

struct DateElement: View {
    var weekday = "FR"
    var day = "05"
    var body: some View {
        VStack {
            Text(weekday)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .padding(15)
            Text(day)
                .font(.subheadline)
                .foregroundStyle(.white)
                .padding(.vertical, 10)
        }
    }
}

#Preview {
    ZStack {
        Color(.black)
        DateStack()
    }
}
