//
//  HabitListView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/7/24.
//

import SwiftData
import SwiftUI

struct HabitListView: View {
    @State var showConfetti = false
    @State var habits: [Habit]

    var body: some View {
        ZStack {
            if showConfetti {
                VStack {
                    ConfettiView(didFinish: $showConfetti)
                    Spacer()
                }
            }
            List {
                Section {
                    HabitsSectionView(habits: habits, showConfetti: $showConfetti, isCheckedSection: false)
                }
                if Habit.hasCheckedItem(habits) {
                    Section("✅ Completed") {
                        HabitsSectionView(habits: habits, showConfetti: $showConfetti, isCheckedSection: true)
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    HabitListView(habits: Demo.habits)
        .preferredColorScheme(.dark)
}
