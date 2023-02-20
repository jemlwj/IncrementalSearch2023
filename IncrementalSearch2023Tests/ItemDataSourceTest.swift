//
//  ItemDataSourceTest.swift
//  IncrementalSearch2023Tests
//
//  Created by Jeremy Lua on 20/2/23.
//  Copyright © 2023 Jeremy Lua. All rights reserved.
//

import XCTest
@testable import IncrementalSearch2023

class ItemDataSourceTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let test = ItemDataSource()
        
        let url = test.buildRequestURL(query: "test", page: 1)
        
        //Ensure all the correct values can be assigned
        XCTAssertEqual(url, URL(string: "https://api.github.com/search/repositories?q=test&page=1"))
        
        XCTAssertNotEqual(url, URL(string: "https://www.google.com"))
    }
}
