//
//  HabitModel.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/5/24.
//

import Foundation
import SwiftData
import SwiftUI

protocol HabitObserver: AnyObject {
    func habitChanged(_ habit: Habit)
}

@Model
class Habit: Identifiable, Equatable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return
            lhs.dayOfWeek == rhs.dayOfWeek &&
            lhs.name == rhs.name &&
            lhs.emoji == rhs.emoji &&
            lhs._description == rhs._description &&
            lhs.count == lhs.count
    }

    var id: UUID
    var emoji: String
    var name: String
    var _description: String
    var dayOfWeek: String
    var isChecked: Bool
    var count = 0

    init(id: UUID = UUID(),
         emoji: String = "🎉",
         name: String,
         description: String = "",
         dayOfWeek: String = "Monday",
         isChecked: Bool = false,
         count: Int = 0)
    {
        self.id = id
        self.isChecked = isChecked
        self.dayOfWeek = dayOfWeek
        self.name = name
        self._description = description
        self.emoji = emoji
        self.count = count
    }

    static func hasCheckedItem(_ habits: [Habit]) -> Bool {
        for habit in habits {
            if habit.isChecked {
                return true
            }
        }
        return false
    }
}

enum Demo {
    static let habits = [Habit(name: "Test1"),
                         Habit(name: "Test2"),
                         Habit(name: "Test3"),
                         Habit(name: "Test4"),
                         Habit(name: "Test5")]
}
