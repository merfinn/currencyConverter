//
//  JSonParser.swift
//  ExchangeAndRates
//
//  Created by merve kavaklioglu on 31.10.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

class JSonParser: NSObject {
    
    static func jsonFromFile(resource:String,extension:String) -> NSArray? {
        
        let url = Bundle.main.url(forResource: Constants.currenciesFileName, withExtension: Constants.currenciesFileType)
        
        guard
            let jsonData = url
            else {
                print(Constants.errorMessage)
                return nil
        }
        guard
            let data = try? Data(contentsOf: jsonData)
            else {
                return nil
        }
        guard
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            else {
                return nil
        }
        return json as? NSArray
    }
    
    static func jsonParser(data:Data) -> NSDictionary?{
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else{ return nil }
        return json as? NSDictionary
    }
}
