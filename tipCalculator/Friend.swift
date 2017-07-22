//
//  Friend.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/19/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import Foundation
import CoreData
// MARK: Friend
/// A class of Friend
class Friend: NSObject, NSCoding {
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let firstName = aDecoder.decodeObject(forKey: "firstName") as? String, let lastName = aDecoder.decodeObject(forKey: "lastName") as? String else {
            print("failed to init")
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
    
    class func loadFriendData(friendIndex index: IndexPath?) -> Friend? {
        print("this is index optional value: \(index)")
        guard let key = index else {
            print("key not available")
            return nil
        }
        let keyValue = String(describing: key)
        print("this is key value: \(keyValue)")
        guard let data = LocalSettings.loadDataSetting(forKey: keyValue) else {
            return nil
        }
        let friend = NSKeyedUnarchiver.unarchiveObject(with: data) as? Friend
        return friend
        
    }
    
    class func saveFriendData(forIndex index: IndexPath?, firstName: String?, lastName: String?, phoneNumber: String?) {
        guard let key = index else {
            print("could not save friend, index not available")
            return
        }
        let keyValue = String(describing: key)
        print(keyValue)
        guard let firstName = firstName, let lastName = lastName else {
            return
        }
        guard let phoneNumber = phoneNumber else {
            let friendObject = Friend(firstName: firstName, lastName: lastName)
            LocalSettings.encodeAndSave(forKey: keyValue, object: friendObject)
            return
        }
        let friend = Friend(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        LocalSettings.encodeAndSave(forKey: keyValue, object: friend)
        return
    }
}



