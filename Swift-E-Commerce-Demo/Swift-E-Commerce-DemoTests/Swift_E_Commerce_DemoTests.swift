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
    
    func test_FlowDIViewModel() {
        //given
        let actions = MainViewModelAction(showDetailView: testDetailView)
        
        //when
        viewModel = flowDI.makeMainViewModel(actions: actions)
        
        //then
        XCTAssertNotNil(viewModel, "ViewModel Not Make")
        
    }
    
    
    func test_ProductList() {
        //MARK: Product List Test Code
        //given
        let actions = MainViewModelAction(showDetailView: testDetailView)
        viewModel = flowDI.makeMainViewModel(actions: actions)
        //when
        
        viewModel.mainUseCase.execute { result in
            self.viewModel.items.onNext(result)
        }
        
        //then
        XCTAssertNotNil(viewModel.items, "testProductList Value Not Nil")
    }
    
    func test_TransfromImage() {
        //given
        
        let actions = MainViewModelAction(showDetailView: testDetailView)
        viewModel = flowDI.makeMainViewModel(actions: actions)
        
        //when
        let testImage = viewModel.mainUseCase.executeimage(entity: viewModel.productItems, at: IndexPath(item: 0, section: 0))
        
        //then
        XCTAssertNoThrow(testImage, "Throw Image")
    }
    
    func test_BannerList() {
        
    }
    
    func testDetailView(product: ProductEntities) {}
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
