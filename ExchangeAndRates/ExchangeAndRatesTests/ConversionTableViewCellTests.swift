//
//  ConversionTableViewCellTests.swift
//  ExchangeAndRatesTests
//
//  Created by merve kavaklioglu on 06.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import XCTest
@testable import ExchangeAndRates

class ConversionTableViewCellTests: XCTestCase {
    
    func testContainsAView() {
        let bundle = Bundle(for: ConversionTableViewCell.self)
        guard
            let _ = bundle.loadNibNamed(Constants.conversionTableViewCellName, owner: nil)?.first as? ConversionTableViewCell
            else {
                return XCTFail("CustomView nib did not contain a UIView")
        }
    }
    
    func testConstructor1() {
        let conversionData = Conversion(fromCurrency: "CAD", toCurrency: "USD")
        conversionData.conversionRate = "0.9001"
        let bundle = Bundle(for: ConversionTableViewCell.self)
        if let cell = bundle.loadNibNamed(Constants.conversionTableViewCellName, owner: nil)?.first as? ConversionTableViewCell {
            cell.fillData(viewModel: conversionData)
            XCTAssertEqual(cell.fromCurrencyLabel.text, "1 CAD")
            XCTAssertEqual(cell.fromCurrencyDescriptionLabel.text, "CAD")
            XCTAssertEqual(cell.conversionSignificantLabel.text , "0.90")
            XCTAssertEqual(cell.conversionSecondSignificantLabel.text, "01")
            XCTAssertEqual(cell.toCurrencyDescription.text, "USD")
        }
    }
}
