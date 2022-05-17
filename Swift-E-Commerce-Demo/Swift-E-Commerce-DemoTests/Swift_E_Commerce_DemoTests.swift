//
//  Swift_E_Commerce_DemoTests.swift
//  Swift-E-Commerce-DemoTests
//
//  Created by Kim dohyun on 2022/05/17.
//

import XCTest
@testable import Swift_E_Commerce_Demo

class Swift_E_Commerce_DemoTests: XCTestCase {
    
    var viewModel: MainViewModel!
    var flowDI: PresenterDI!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        flowDI = AppFlowDI()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
        self.flowDI = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testFlowDIViewModel() {
        //given
        viewModel = flowDI.makeMainViewModel()
        
        XCTAssertNotNil(viewModel, "ViewModel Not Make")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
