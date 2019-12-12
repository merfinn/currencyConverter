//
//  UserDefaults.swift
//  ExchangeAndRates
//
//  Created by merve kavaklioglu on 05.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

class UserDefaultsManager { //To store some data for user preferences
    
    static func save(object:Any,key: String) {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false) {
            UserDefaults.standard.set(savedData, forKey: key)
        }
    }
    
    static func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func get(key: String) -> Any? {
        guard
            let savedObject = UserDefaults.standard.object(forKey: key) as? Data,
            let decodedObject = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedObject) as? [Any]
            else{
                return nil
        }
        return decodedObject
    }
}
