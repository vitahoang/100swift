//
//  HabitsSectionView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/8/24.
//

import SwiftData
import SwiftUI
import UniformTypeIdentifiers

struct HabitsSectionView: View {
    @Environment(\.modelContext) var modelContext
    @State var habits: [Habit]
    @Binding var showConfetti: Bool
    @State private var dragging: Habit?
    @State private var isDetailHabieViewActive: Bool = false

    let isCheckedSection: Bool

    var body: some View {
        ForEach(habits) { habit in
            if habit.isChecked == isCheckedSection {
                HStack {
                    Image(systemName: habit.isChecked ? "checkmark.square.fill" : "square").onTapGesture {
                        if !habit.isChecked {
                            showConfetti = true
                        }
                        habit.isChecked.toggle()
                    }
                    Text(habit.emoji)
                    if habit.isChecked {
                        Text(habit.name)
                            .frame(maxHeight: 20)
                            .strikethrough()
                    } else {
                        Text(habit.name)
                            .frame(maxHeight: 20)
                    }
                    Spacer()
                }
//                .background {
//                    NavigationLink(destination: DetailHabitView(habit: habit)) {}
//                        .opacity(0)
//                }
//                .swipeActions(edge: .trailing) {
//                    Button(role: .destructive) {
//                        if let index = habits.firstIndex(of: habit) {
//                            modelContext.delete(habit)
//                        }
//                    } label: {
//                        Label("Delete", systemImage: "trash.fill")
//                    }
//                }
//                .onDrag {
//                    self.dragging = habit
//                    return NSItemProvider(object: NSString())
//                }
//                .onDrop(of: [UTType.text], delegate: DragDelegate(current: $dragging))
            }
        }
//        .onMove(perform: move)
        .listRowSeparator(.hidden)
        .listRowBackground(EmptyView())
    }

//    func move(from source: IndexSet, to destination: Int) {
//        habits.move(fromOffsets: source, toOffset: destination)
//        print("move")
//    }
}

#Preview {
    HabitsSectionView(habits: [Habit(name: "test")], showConfetti: .constant(true), isCheckedSection: true)
}
