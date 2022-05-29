//
//  MainUseCase.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/18.
//

import Foundation
import RxSwift

protocol MainUseCase {
    func execute() -> Observable<MainEntity>
    func executeDecimalCost(entity: Int) -> String
    func executeImageData(entity: String) -> Observable<Data>
    func executeLowerPriceFilter(entity: [ProductEntities]) -> Observable<[Int]>
}


final class DefaultMainUseCase: MainUseCase {
    
    private let mainRepository: MainRepository
    
    init(mainRepository: MainRepository) {
        self.mainRepository = mainRepository
    }
    
    func execute() -> Observable<MainEntity> {
        return mainRepository.fetchMainProductList()
    }

    func executeDecimalCost(entity: Int) -> String {
        return mainRepository.fetchTransformDecimal(entity: entity)
    }
    
    func executeImageData(entity: String) -> Observable<Data> {
        return mainRepository.fetchTransformImage(entity: entity)
    }
    
    func executeLowerPriceFilter(entity: [ProductEntities]) -> Observable<[Int]> {
        return mainRepository.fetchLowerPrice(entity: entity)
    }
    
}
