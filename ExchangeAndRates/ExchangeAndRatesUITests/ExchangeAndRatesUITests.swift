//
//  ExchangeAndRatesUITests.swift
//  ExchangeAndRatesUITests
//
//  Created by merve kavaklioglu on 31.10.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import XCTest

class ExchangeAndRatesUITests: XCTestCase {
    var app: XCUIApplication!
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testViewControllersAndTap() {
        app.launch()
        
        // Make sure we're displaying onboarding
        XCTAssertTrue(app.otherElements["conversionVCAI"].exists)
        // Tap the "Done" button
        app.buttons["add"].tap()
        // Onboarding should no longer be displayed
        XCTAssertTrue(app.otherElements["currencyVCAI"].exists)
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
