//
//  ItemTest.swift
//  IncrementalSearch2023Tests
//
//  Created by Jeremy Lua on 18/2/23.
//  Copyright © 2023 Jeremy Lua. All rights reserved.
//

import XCTest
@testable import IncrementalSearch2023

class ItemTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testItem() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testItem = Item(identifier: 0, full_name: "hello world", html_url: "www.google.com")
        
        //Ensure all the correct values can be assigned
        XCTAssertEqual(testItem.identifier, 0)
        XCTAssertEqual(testItem.full_name, "hello world")
        XCTAssertEqual(testItem.html_url, "www.google.com")
        
        //Check for invalid values
        XCTAssertNotEqual(testItem.identifier, 1000)
        XCTAssertNotEqual(testItem.full_name, "foobar")
        XCTAssertNotEqual(testItem.html_url, "www.apple.com")
    }
}
