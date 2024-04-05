//
//  OrderModel.swift
//  Cupcake
//
//  Created by Vita Hoang on 4/5/24.
//

import SwiftUI

@Observable
class Order: Decodable, Encodable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false
    var addSprinkles = false
    var name = "" {
        didSet {
            UserDefaults.standard.setValue(name, forKey: "name")
        }
    }

    var streetAddress = "" {
        didSet {
            UserDefaults.standard.setValue(streetAddress, forKey: "streetAddress")
        }
    }

    var city = "" {
        didSet {
            UserDefaults.standard.setValue(city, forKey: "city")
        }
    }

    var zip = "" {
        didSet {
            UserDefaults.standard.setValue(zip, forKey: "zip")
        }
    }

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        if checkAllWhiteSpace(text: name) || checkAllWhiteSpace(text: streetAddress) || checkAllWhiteSpace(text: city) || checkAllWhiteSpace(text: zip) {
            return false
        }
        return true
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }

    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }

    func checkAllWhiteSpace(text: String) -> Bool {
        for letter in text {
            if letter != " " {
                return false
            }
        }
        return true
    }
}
