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
    
    func testDatasource() {
        let dataSource = ItemDataSource()
        
        let url = dataSource.buildRequestURL(query: "test", page: 1)
        
        //Ensure all the correct values can be assigned
        XCTAssertEqual(url, URL(string: "https://api.github.com/search/repositories?q=test&page=1"))
        XCTAssertNotEqual(url, URL(string: "https://www.google.com"))
        
        dataSource.loadList(query: "test", completion: { item in
            //Ensure throttling is working
            XCTAssertNotEqual(ItemDataSource.lastAPICall, Date(timeIntervalSince1970: 0))
        }, failure: { message in
            //Shouldn't be able to reach here
            XCTAssertEqual(message, "Due to API call rate limiting, the web request can only be made every 5 seconds. Please try again later")
        })
        
        //Request a second time a second time
        dataSource.loadList(query: "test", completion: { item in
            //Shouldn't be able to reach here
        }, failure: { message in
            //Ensure throttling error message is returning
            XCTAssertEqual(message, "Due to API call rate limiting, the web request can only be made every 5 seconds. Please try again later")
        })
    }
}
