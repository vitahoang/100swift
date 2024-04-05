//
//  ObserableView.swift
//  iExpense
//
//  Created by Vita Hoang on 4/5/24.
//

import SwiftUI

struct AddView: View {
    @State private var name = "hung"
    @State private var type = "Personal"
    @State private var amount = 10.0
    var expenses: Expenses
    public let types = Expenses().itemType
    
    @Environment(\.dismiss) var dismiss


    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    print(item)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
