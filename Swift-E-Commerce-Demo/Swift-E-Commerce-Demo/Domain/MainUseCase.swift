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
    
    
}
