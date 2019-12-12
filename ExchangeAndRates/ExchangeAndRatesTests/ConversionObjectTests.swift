//
//  ConversionObjectTests.swift
//  ExchangeAndRatesTests
//
//  Created by merve kavaklioglu on 06.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import XCTest
@testable import ExchangeAndRates

class ConversionObjectTests: XCTestCase {
    
    func testConstructor1() {
        let fromCurrency = "CAD"
        let conversion = Conversion(fromCurrency: fromCurrency)
        XCTAssertEqual(conversion.fromCurrency, "CAD")
        XCTAssertEqual(conversion.toCurrency, nil)
        XCTAssertEqual(conversion.conversionSignificant, nil)
        XCTAssertEqual(conversion.conversionSecondSignificant, nil)
        XCTAssertEqual(conversion.conversionRate, nil)
    }
    
    func testConstructor2() {
        let fromCurrency = "CAD"
        let toCurrency = "USD"
        let conversion = Conversion(fromCurrency: fromCurrency, toCurrency: toCurrency)
        XCTAssertEqual(conversion.fromCurrency, "CAD")
        XCTAssertEqual(conversion.toCurrency, "USD")
        XCTAssertEqual(conversion.conversionSignificant, nil)
        XCTAssertEqual(conversion.conversionSecondSignificant, nil)
        XCTAssertEqual(conversion.conversionRate, nil)
    }
    
    func testDidSetConversionRatePredicted1() {
        let fromCurrency = "CAD"
        let toCurrency = "USD"
        let conversionRate = "3.2342"
        var conversion = Conversion(fromCurrency: fromCurrency, toCurrency: toCurrency)
        conversion.conversionRate = conversionRate
        XCTAssertEqual(conversion.conversionRate, "3.2342")
        XCTAssertEqual(conversion.conversionSignificant, "3.23")
        XCTAssertEqual(conversion.conversionSecondSignificant, "42")
        
    }
    
    func testDidSetConversionRatePredicted2() {
        let fromCurrency = "CAD"
        let toCurrency = "USD"
        let conversionRate = "123.2342"
        var conversion = Conversion(fromCurrency: fromCurrency, toCurrency: toCurrency)
        conversion.conversionRate = conversionRate
        XCTAssertEqual(conversion.conversionSignificant, "123.23")
        XCTAssertEqual(conversion.conversionSecondSignificant, "42")
        XCTAssertEqual(conversion.conversionRate, "123.2342")
    }
    
    func testDidSetConversionRateUnPredicted1() {
        let fromCurrency = "CAD"
        let toCurrency = "USD"
        let conversionRate = "23423.2342324"
        var conversion = Conversion(fromCurrency: fromCurrency, toCurrency: toCurrency)
        conversion.conversionRate = conversionRate
        XCTAssertEqual(conversion.conversionSignificant, "23423.23")
        XCTAssertEqual(conversion.conversionSecondSignificant, "42")
        XCTAssertEqual(conversion.conversionRate, "23423.2342324")
    }
    func testDidSetConversionRateUnPredicted2() {
        let fromCurrency = "CAD"
        let toCurrency = "USD"
        let conversionRate = "1.0"
        var conversion = Conversion(fromCurrency: fromCurrency, toCurrency: toCurrency)
        conversion.conversionRate = conversionRate
        XCTAssertEqual(conversion.conversionSignificant, "1.0")
        XCTAssertEqual(conversion.conversionSecondSignificant, "")
        XCTAssertEqual(conversion.conversionRate, "1.0")
    }
    
    func testDidSetConversionRateUnPredicted3() {
        let fromCurrency = "CAD"
        let toCurrency = "USD"
        let conversionRate = "23423.2"
        var conversion = Conversion(fromCurrency: fromCurrency, toCurrency: toCurrency)
        conversion.conversionRate = conversionRate
        XCTAssertEqual(conversion.conversionSignificant, "23423.2")
        XCTAssertEqual(conversion.conversionSecondSignificant, "")
        XCTAssertEqual(conversion.conversionRate, "23423.2")
    }
    func testDidSetConversionRateUnPredicted4() {
        let fromCurrency = "CAD"
        let toCurrency = "USD"
        let conversionRate = ""
        var conversion = Conversion(fromCurrency: fromCurrency, toCurrency: toCurrency)
        conversion.conversionRate = conversionRate
        XCTAssertEqual(conversion.conversionSignificant, nil)
        XCTAssertEqual(conversion.conversionSecondSignificant, nil)
        XCTAssertEqual(conversion.conversionRate, "")
    }
}
