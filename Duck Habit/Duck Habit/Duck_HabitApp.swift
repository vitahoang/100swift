//
//  Duck_HabitApp.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/5/24.
//

import SwiftUI

@main
struct Duck_HabitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Habit.self)
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
