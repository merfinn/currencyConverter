//
//  Definitions.swift
//  ExchangeAndRates
//
//  Created by merve kavaklioglu on 03.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit


enum Constants {
    static let errorMessage = "There is a problem with ... "
    static let apiURL = "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios"
    static let apiQueryItem = "pairs"
    static let currenciesFileName = "currencies"
    static let currenciesFileType = "json"
    static let currencySelectionViewControllerIdentifier = "CurrencySelectionVC"
    static let conversionTableViewCellIdentifier = "conversionIdentifier"
    static let conversionTableViewCellName = "ConversionTableViewCell"
    static let conversionViewControllerTitle = "Rates & converter"
    static let conversionViewControllerAccesibilityIdentifier = "conversionVCAI"
    static let currencyViewControllerAccesibilityIdentifier = "currencyVCAI"
    static let currencyTableViewCellIdentifier = "currencyIdentifier"
    static let currencyTableViewCellName = "CurrencyTableViewCell"
    static let currencyViewControllerFromSelectionTitle = "First Currency"
    static let currencyViewControllerToSelectionTitle = "Second Currency"
    static let mainName = "Main"
    static let saveManagerKey = "SaveManagerKey"
    static let userDefaultsConversionKey = "conversionsKey"
    static let currencySelectionRowHeight = 56
}


