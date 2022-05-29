//
//  Swift_E_Commerce_DemoTests.swift
//  Swift-E-Commerce-DemoTests
//
//  Created by Kim dohyun on 2022/05/17.
//

import XCTest
import RxSwift

@testable import Swift_E_Commerce_Demo

class Swift_E_Commerce_DemoTests: XCTestCase {
    
    var viewModel: MainViewModel!
    var flowDI: PresenterDI!
    var disposeBag: DisposeBag!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        flowDI = AppFlowDI()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
        self.flowDI = nil
        self.disposeBag = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //ViewModel init Success
    func test_FlowDIViewModel() {
        //given
        let actions = MainViewModelAction(showDetailView: testDetailView)
        
        //when
        viewModel = flowDI.makeMainViewModel(actions: actions)
        
        //then
        XCTAssertNotNil(viewModel, "ViewModel Not Make")
        
    }
    
    
    //상품 가격 Decimal 변환 Success
    func test_DecimalCost() {
    
        //given
        let useCase: DefaultMainUseCase = DefaultMainUseCase(mainRepository: DefaultMainRepository())
        
        //when
        let testValue = useCase.executeDecimalCost(entity: 100000)
        
        //then
        XCTAssertEqual("100,000원", testValue, "Decimal Cost Value Equal")
    }
    
    func testDetailView(product: ProductEntities) {}
    
    
    //최저가 상품 List 반환 Success
    func test_Lower_Product() {
        
        //given
        let lowerUseCase: DefaultMainUseCase = DefaultMainUseCase(mainRepository: DefaultMainRepository())
        let actions = MainViewModelAction(showDetailView: testDetailView)
        viewModel = flowDI.makeMainViewModel(actions: actions)
        
        
        //when
        let testLowerPrice = lowerUseCase.executeLowerPriceFilter(entity: viewModel.productItems!.info)
        
        
        //then
        XCTAssertNotNil(testLowerPrice, "Lower Price Value Nil Exception Error")
        
    }
    
    //최고가 상품 Unit Test
    func test_High_Porduct() {
        
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
