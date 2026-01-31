//
//  OrderViewModel.swift
//  CupcakeCorner
//
//  Created by Amier Davis on 1/29/26.
//

import Observation
import Foundation

@Observable
class Order: Codable {
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
    
    init() {
        name = UserDefaults.standard.string(forKey: "name") ?? ""
        streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        zip = UserDefaults.standard.string(forKey: "zip") ?? ""
    }
    
    required init(from decoder: Decoder) {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let name = try container.decode(String.self, forKey: ._name)
            let city = try container.decode(String.self, forKey: ._city)
            let streetAddress = try container.decode(String.self, forKey: ._streetAddress)
            let zip = try container.decode(String.self, forKey: ._zip)
            
            self.name = name
            self.city = city
            self.streetAddress = streetAddress
            self.zip = zip
        } catch {
            
        }
    }

    static var types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = "" {
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    var streetAddress = "" {
        didSet {
            UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        }
    }
    var city = "" {
        didSet {
            UserDefaults.standard.set(city, forKey: "city")
        }
    }
    var zip = "" {
        didSet {
            UserDefaults.standard.set(zip, forKey: "zip")
        }
    }
    
    var hasValidAddress: Bool {
        let anyFieldIsEmpty = name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty
        let anyFieldContainsWhiteSpace =
            name.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            streetAddress.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            city.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            zip.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        if anyFieldIsEmpty || anyFieldContainsWhiteSpace {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity) / 2
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
