//
//  SearchAlgorithmsTests.swift
//  ExchangeAndRatesTests
//
//  Created by merve kavaklioglu on 06.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import XCTest
@testable import ExchangeAndRates

class SearchAlgorithmsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchingForEnableCell() {
        let cellCurrencyTest1 = "CAD" //related row in a list
        let cellCurrencyTest2 = "CHF" //related row in a list
        let cellCurrencyTest3 = "GBP" //related row in a list

        let currencyVC = CurrencySelectionViewController()
        currencyVC.isFromCurrency = true
        
        var conversions = [Conversion]()
        let aConversion = Conversion(fromCurrency: "CAD", toCurrency: "USD")
        let bConversion = Conversion(fromCurrency: "CAD", toCurrency: "EUR")
        let cConversion = Conversion(fromCurrency: "CAD", toCurrency: "GBP")
        let dConversion = Conversion(fromCurrency: "AUD", toCurrency: "USD")
        let eConversion = Conversion(fromCurrency: "AUD", toCurrency: "EUR")
        let fConversion = Conversion(fromCurrency: "AUD", toCurrency: "GBP")
        let gConversion = Conversion(fromCurrency: "BRL", toCurrency: "CHF")
        conversions.append(aConversion)
        conversions.append(bConversion)
        conversions.append(cConversion)
        conversions.append(dConversion)
        conversions.append(eConversion)
        conversions.append(fConversion)
        conversions.append(gConversion)
        
        currencyVC.conversions = conversions
        currencyVC.conversion  = Conversion(fromCurrency: "CAD")
        
        XCTAssertFalse(currencyVC.decideWhetherEnable(cellCurrency: cellCurrencyTest1))
        XCTAssertTrue(currencyVC.decideWhetherEnable(cellCurrency: cellCurrencyTest2))
        XCTAssertFalse(currencyVC.decideWhetherEnable(cellCurrency: cellCurrencyTest3))

        currencyVC.conversion  = Conversion(fromCurrency: "AUD")
        
        XCTAssertTrue(currencyVC.decideWhetherEnable(cellCurrency: cellCurrencyTest1))
        XCTAssertTrue(currencyVC.decideWhetherEnable(cellCurrency: cellCurrencyTest2))
        XCTAssertFalse(currencyVC.decideWhetherEnable(cellCurrency: cellCurrencyTest3))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
