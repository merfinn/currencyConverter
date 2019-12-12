//
//  ConversionDataSource.swift
//  ExchangeAndRates
//
//  Created by merve kavaklioglu on 02.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

class ConversionDataSource: NSObject {
    
    var conversions:[Conversion]
    var pairs:[String] = [String]()
    
    override init() {
        conversions = []
    }
    
    func setConversions(newConversions: [Conversion]) ->Void {
        conversions = newConversions
        if(conversions.count>0) {
            UserDefaultsManager.save(object: conversions, key: Constants.userDefaultsConversionKey)
        }
        else{
            UserDefaultsManager.remove(key: Constants.userDefaultsConversionKey)
        }
        updateLongPollingPairs()
        pairs = conversions.map{$0.fromCurrency+($0.toCurrency ?? "")}
    }
    
    func getConversions() -> [Conversion] {
        conversions = UserDefaultsManager.get(key: Constants.userDefaultsConversionKey) as? [Conversion] ?? [Conversion]()
        updateLongPollingPairs()
        return conversions
    }
    
    func updateLongPollingPairs() {
        pairs = conversions.map{$0.fromCurrency+($0.toCurrency ?? "")}
    }
}
