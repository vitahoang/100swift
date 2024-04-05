//
//  ListExpenseView.swift
//  iExpense
//
//  Created by Vita Hoang on 4/5/24.
//

import SwiftUI

struct ListExpenseView: View {
    var expenses: Expenses
    var validType: Set<String>
    var validTypeList: [String] {
            return Array(validType)
        }
    var body: some View {
        List {
            ForEach(0 ..< validTypeList.count, id: \.self) { index in
                Section {
                    ForEach(expenses.items) { item in
                        if item.type == validTypeList[index] {
                            HStack {
                                Text(item.name)
                                    .font(.headline)
                                Spacer()
                                if item.amount < 10.0 {
                                    Text(item.amount, format: .currency(code: "USD"))
                                        .foregroundStyle(.green)
                                        .bold()
                                }
                                if item.amount < 100.0 && item.amount >= 10.0 {
                                    Text(item.amount, format: .currency(code: "USD"))
                                        .foregroundStyle(.yellow)
                                        .bold()
                                }
                                if item.amount >= 100.0 {
                                    Text(item.amount, format: .currency(code: "USD"))
                                        .foregroundStyle(.red)
                                        .bold()
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeItem)
                } header: {
                    Text(validTypeList[index])
                }
            }
        }
    }

    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ZStack {
        ListExpenseView(expenses: Expenses(), validType: ["Personal", "Business"])
    }
}
