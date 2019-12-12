//
//  Conversion.swift
//  ExchangeAndRates
//
//  Created by merve kavaklioglu on 02.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

struct Conversion: Codable{
    let fromCurrency: String!
    var toCurrency: String?
    var conversionSignificant: String?
    var conversionSecondSignificant: String?
    var conversionRate: String?{ //immidiately parses the values
        didSet {
            if conversionRate != nil {
                if let index = conversionRate?.firstIndex(of: ".") {
                    let firstPart = String(conversionRate?[...index] ?? "")
                    let secondPart = String(String(conversionRate?[index...] ?? "").dropFirst())
                    conversionSignificant = firstPart + String(secondPart.prefix(2))
                    conversionSecondSignificant = String(String(secondPart.dropFirst(2)).prefix(2))
                }
            }
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case fromCurrency
        case toCurrency
    }
    
    init(fromCurrency: String) {
        self.fromCurrency = fromCurrency
    }
    
    init(fromCurrency: String, toCurrency: String) {
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
    }
}
