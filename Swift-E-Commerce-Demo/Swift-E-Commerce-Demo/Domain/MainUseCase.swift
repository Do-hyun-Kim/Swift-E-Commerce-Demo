//
//  MainUseCase.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/18.
//

import Foundation
import RxSwift

protocol MainUseCase {
    func execute(completion: @escaping(([ProductEntities]) -> Void))
    func executeDecimalCost(entity: [ProductEntities], at indexPath: IndexPath) -> String
//    func executeImageData(entity: [ProductEntities], at indexpath: IndexPath) -> Observable<Data>
}


final class DefaultMainUseCase: MainUseCase {
    
    private let mainRepository: MainRepository
    
    init(mainRepository: MainRepository) {
        self.mainRepository = mainRepository
    }
    
    func execute(completion: @escaping (([ProductEntities]) -> Void)) {
        return mainRepository.fetchMainProductList { result in
            completion(result)
        }
    }
    
    func executeDecimalCost(entity: [ProductEntities], at indexPath: IndexPath) -> String {
        
        return mainRepository.fetchTransformDecimal(entity: entity, at: indexPath)
    }
    
//    func executeImageData(entity: [ProductEntities], at indexpath: IndexPath) -> Observable<Data> {
//        return
//    }
    
    
    
    
}
