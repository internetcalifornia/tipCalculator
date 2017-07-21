//
//  LocalSettings.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/19/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import Foundation

final public class LocalSettings {
    static let defaults = UserDefaults.standard
    
    public class func encodeAndSave(forKey key: String, object: NSCoding) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        saveSetting(forKey: key, value: data)
    }
    
    /** load data object
     
        `key` is a string value that pulls data from the user defaults
     
     */
    public class func loadDataSetting(forKey key: String) -> Data? {
        return defaults.data(forKey: key)
    }
    
    /// load a string from a key in the user default
    public class func loadStringSetting(forKey key: String) -> String? {
        return defaults.string(forKey: key)
    }
    
    public class func saveSetting(forKey key: String, value: Any) {
        defaults.set(value, forKey: key)
    }
}
