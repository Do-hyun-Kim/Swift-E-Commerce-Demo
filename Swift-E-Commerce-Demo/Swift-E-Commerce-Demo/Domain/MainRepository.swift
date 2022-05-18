//
//  MainRepository.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/18.
//

import Foundation

protocol MainRepository {
    func fetchMainProductList(complection:  @escaping(([ProductEntities]) -> Void))
}

final class DefaultMainRepository: MainRepository {
    
    func fetchMainProductList(complection: @escaping (([ProductEntities]) -> Void)) {
        do {
            let decoder = JSONDecoder()
            guard let bundle = Bundle.main.url(forResource: "product_list", withExtension: "json") else { return }
            let productData = try decoder.decode([ProductEntities].self, from: Data(contentsOf: bundle))
            complection(productData)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
