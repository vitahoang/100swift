//
//  ContentView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/5/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habit]
    @State private var activeTab = "Home"
    @State private var showAddTaskView = false

    var body: some View {
        TabView(selection: $activeTab) {
            HomeView(habits: habits)
                .tabItem {
                    Image(systemName: "app.badge.checkmark.fill")
                    Text("Today")
                }
                .tag("Home")
            Text("")
                .tabItem {
                    Image(systemName: "plus.app.fill")
                    Text("New")
                }
                .tag("New")
            Text("The content of the second view")
                .tabItem {
                    Image(systemName: "rectangle.checkered")
                    Text("Priority")
                }
                .tag("Priority")
        }
        .onChange(of: activeTab) {
            print(activeTab)
            if activeTab == "New" {
                activeTab = "Home"
                showAddTaskView = true
            }
        }
        .sheet(isPresented: $showAddTaskView) {
            AddTaskView()
                .presentationDetents([.fraction(0.8)])
                .presentationDragIndicator(.hidden)
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/ .dark/*@END_MENU_TOKEN@*/)
        .listStyle(.plain)
    }
}

#Preview {
    ContentView()
}
