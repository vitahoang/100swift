//
//  ContentView.swift
//  iExpense
//
//  Created by Vita Hoang on 4/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            ZStack {
                ListExpenseView(expenses: expenses, validType: expenses.validType)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Add", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
                ToolbarItem {
                    if expenses.items.count != 0 {
                        EditButton()
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }

    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var itemType = ["Business", "Personal", "Food"]
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    var validType: Set<String> {
        get {
            checkEmptySection()
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
    
    func checkEmptySection() -> Set<String>{
        var types = Set<String>()
        for item in self.items {
            for type in itemType {
                if item.type == type {
                    types.insert(type)
                }
            }
        }
        return types
    }
}

#Preview {
    ContentView()
}
