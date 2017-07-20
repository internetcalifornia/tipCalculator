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
class Friend {
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
}

