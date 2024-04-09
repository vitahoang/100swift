//
//  HomeView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/6/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var habits: [Habit]

    @State private var dragging: Habit?
    @State private var totalDailyGoalBackground = Color.secondary
    @State private var totalDailyGoalIcon = "🎯"
    @State private var scaleScore = 1.0

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    DateStack()
                    HStack {
                        Text("Today")
                            .font(.headline)
                            .foregroundStyle(.primary)

                        Text("\(totalDailyGoalIcon) \(habits.filter { $0.isChecked == true }.count)/\(habits.count)")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 10)
                            .background(totalDailyGoalBackground)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                            .scaleEffect(scaleScore)
                            .animation(.easeInOut(duration: 0.5), value: scaleScore)

                        Spacer()
                    }
                    .padding(.leading, 15)
                    HabitListView(habits: habits)
                }
            }
            .navigationTitle("Hello, Vita 😊")
            .preferredColorScheme(.dark)
            .onChange(of: totalDailyGoalBackground) {
                withAnimation {
                    if totalDailyGoalBackground != Color.secondary {
                        totalDailyGoalIcon = "🎉"
                        scaleScore += 0.3
                    } else {
                        totalDailyGoalIcon = "🎯"
                    }
                } completion: {
                    scaleScore = 1
                }
            }
        }
    }
}

//struct DragDelegate<Habit: Equatable>: DropDelegate {
//    @Binding var current: Habit?
//
//    func dropUpdated(info: DropInfo) -> DropProposal? {
//        DropProposal(operation: .move)
//    }
//
//    func performDrop(info: DropInfo) -> Bool {
//        current = nil
//        return true
//    }
//}

#Preview {
    HomeView(habits: Demo.habits)
}
