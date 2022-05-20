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
    func executeimage(entity: [ProductEntities], at indexpath: IndexPath)
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
    
    //TODO: UseCase Parameter값 수정 -> entity 값 UseCase에 접근은 가능하나 Image 처리만을 위한 String으로 지정하는것이 적합
    func executeimage(entity: [ProductEntities], at indexpath: IndexPath) {
        mainRepository.fetchTransformImage(entity: entity[indexpath.item].productImage)
    }
    
    
    
}
