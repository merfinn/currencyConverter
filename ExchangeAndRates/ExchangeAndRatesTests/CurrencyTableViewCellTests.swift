//
//  CurrencyTableViewCellTests.swift
//  ExchangeAndRatesTests
//
//  Created by merve kavaklioglu on 07.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import XCTest
@testable import ExchangeAndRates

class CurrencyTableViewCellTests: XCTestCase {

    func testContainsAView() {
        let bundle = Bundle(for: CurrencyTableViewCell.self)
        guard
            let _ = bundle.loadNibNamed(Constants.currencyTableViewCellName, owner: nil)?.first as? CurrencyTableViewCell
            else {
                return XCTFail("CustomView nib did not contain a UIView")
        }
    }
    
    func testConstructor1() {
        let currency = "CAD"
        let bundle = Bundle(for: CurrencyTableViewCell.self)
        if let cell = bundle.loadNibNamed(Constants.currencyTableViewCellName, owner: nil)?.first as? CurrencyTableViewCell {
            cell.fillData(viewModel: currency)
            XCTAssertEqual(cell.currencyLabel.text, "CAD")
            XCTAssertEqual(cell.currencyImageView.backgroundColor, UIColor.black)
        }
    }
}
