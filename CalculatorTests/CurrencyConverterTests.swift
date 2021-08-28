//
//  CurrencyConverterTests.swift
//  CalculatorTests
//
//  Created by Mahmoud Mohamed on 01/07/2021.
//

import Foundation
import XCTest
@testable import Calculator

class CurrencyConverterTests : XCTestCase{
    

    
    
    /// call before the test method can we init things
    override func setUp() {
    
    }
    /// call after the method done can we terminate things or free memory
    override func tearDown() {
        
    }
    /// test fetch data method and url of api
    func testFetchData(){
        var myExp = expectation(description: "Waiting while fetchig")
        APIConnect.shared.fetchData(amount: "1") { data, error in
            if let error = error{
                XCTFail()
            }else{
                var result = "\(data?.conversion_result ?? 0)"
                print("Result:\(result)")
                XCTAssertEqual(result, "0.06382")
                myExp.fulfill()
            }
        }
         waitForExpectations(timeout: 5, handler: nil)
    
}

}
