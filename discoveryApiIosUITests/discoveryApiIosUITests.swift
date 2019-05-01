//
//  discoveryApiIosUITests.swift
//  discoveryApiIosUITests
//
//  Created by Rafael Pugliese on 06/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import XCTest

class discoveryApiIosUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Abusive Experience Report API")/*[[".cells.containing(.staticText, identifier:\"Views Abusive Experience Report data, and gets a list of sites that have a significant number of abusive experiences.\")",".cells.containing(.staticText, identifier:\"Abusive Experience Report API\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Button"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Accelerated Mobile Pages (AMP) URL API")/*[[".cells.containing(.staticText, identifier:\"This API contains a single method, batchGet. Call this method to retrieve the AMP URL (and equivalent AMP Cache URL) for given public URL(s).\")",".cells.containing(.staticText, identifier:\"Accelerated Mobile Pages (AMP) URL API\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Button"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Access Approval API")/*[[".cells.containing(.staticText, identifier:\"An API for controlling access to data by Google personnel.\")",".cells.containing(.staticText, identifier:\"Access Approval API\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Button"].tap()
        tablesQuery.children(matching: .cell).element(boundBy: 3).buttons["Button"].tap()
        app.navigationBars["discoveryApiIos.ApiTableView"].buttons["Favoritas"].tap()
    }
}
