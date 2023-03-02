//
//  Order.swift
//  Cupcake Corner
//
//  Created by Yashraj jadhav on 28/02/23.
//

import SwiftUI

 //MARK: - By conforming to the ObservableObject protocol, you can define a data model that can be observed by other views, view models, or controllers in your app  , @Published property wrapper applied to any properties that need to be observed, which will notify the observers whenever the property value changes.


class Order : ObservableObject  , Codable {
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var name = ""
    @Published var StreetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    var hasValidAddress : Bool {
        if name.isEmpty || StreetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        if name.isAllWhiteSpaces || StreetAddress.isAllWhiteSpaces || city.isAllWhiteSpaces || zip.isAllWhiteSpaces {
                    return false
                }
        
        return true
    }
    
    
    
    
    
    
    
    var cost : Double {
        // $2 per cake

        var cost = Double(quantity) * 2
        
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    

    //MARK: -         Encoding and Decoding

    
    enum CodingKeys : CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    init(){ }
    
    func encode (to encoder : Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(StreetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init (from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        StreetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    
    
}

fileprivate extension String {
    
    
    var isAllWhiteSpaces : Bool {
        guard !self.isEmpty else {return false}
        return self.drop(while: {$0 == " "}).isEmpty
    }
}

 //MARK: -  in the isAllWhiteSpaces computed property extension, the guard statement checks if the string is empty, and if so, immediately returns false. This is because an empty string cannot be considered to be made up of only whitespace characters. The guard statement helps to ensure that the function is working with valid input and avoids potential runtime errors that could occur if the input was invalid.
