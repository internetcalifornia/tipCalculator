//
//  Friend.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/19/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import Foundation

// MARK: Friend
/// A class of Friend
class Friend: NSObject, NSCoding {
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let firstName = aDecoder.decodeObject(forKey: "firstName") as? String, let lastName = aDecoder.decodeObject(forKey: "lastName") as? String else {
            return nil
        }
        guard let phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String else {
            self.init(firstName: firstName, lastName: lastName)
            return
        }
        self.init(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
    }
    
    var firstName: String
    var lastName: String
    var phoneNumber: String?
    var fullName: String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    /// Initialize Friend class with a Phone Number
    convenience init(firstName: String, lastName: String, phoneNumber: String) {
        self.init(firstName: firstName, lastName: lastName)
        self.phoneNumber = phoneNumber
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
    }
}

