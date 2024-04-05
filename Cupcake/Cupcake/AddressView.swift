//
//  AddressView.swift
//  Cupcake
//
//  Created by Vita Hoang on 4/5/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
                    .keyboardType(.numberPad)
            }
            .onAppear(perform: {
                order.name = UserDefaults.standard.string(forKey: "name") ?? ""
                order.streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
                order.city = UserDefaults.standard.string(forKey: "city") ?? ""
                order.zip = UserDefaults.standard.string(forKey: "zip") ?? ""
            })

            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
