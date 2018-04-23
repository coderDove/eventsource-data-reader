//
//  NDREventSerieTests.swift
//  NetronixDataReaderTests
//
//  Created by Anton Holub on 4/23/18.
//  Copyright © 2018 Anton Holub. All rights reserved.
//

import XCTest
@testable import NetronixDataReader

class NDREventSerieTests: XCTestCase {
    
    var message1: Data?
    var message2: Data?
    var message3: Data?
    var testBundle: Bundle?
    
    override func setUp() {
        super.setUp()
        
        self.testBundle =  Bundle(for: type(of: self) )
    
        self.message1 = try? Data(contentsOf: URL(fileURLWithPath: self.testBundle!.path(forResource: "message01", ofType: "json")!), options: .mappedIfSafe)
        self.message2 = try? Data(contentsOf: URL(fileURLWithPath: self.testBundle!.path(forResource: "message02", ofType: "json")!), options: .mappedIfSafe)
        self.message3 = try? Data(contentsOf: URL(fileURLWithPath: self.testBundle!.path(forResource: "message03", ofType: "json")!), options: .mappedIfSafe)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        self.testBundle = nil
        self.message1 = nil
        self.message2 = nil
        self.message3 = nil
    }
    
    func testValidJsonIsParsedToNonNilNDREventSeries() {
        XCTAssertNotNil(try JSONDecoder().decode([NDREventSerie].self, from: self.message1!))

    }
    
    
}
