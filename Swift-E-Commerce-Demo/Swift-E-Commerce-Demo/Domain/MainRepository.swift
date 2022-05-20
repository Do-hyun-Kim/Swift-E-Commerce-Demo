//
//  MainRepository.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/18.
//

import Foundation
import RxSwift

protocol MainRepository {
    func fetchMainProductList(completion:  @escaping(([ProductEntities]) -> Void))
    func fetchTransformDecimal(entity: [ProductEntities], at indexPath: IndexPath) -> String
    func fetchTransformImage(entity: String) -> Data
}

final class DefaultMainRepository: MainRepository {
    
    func fetchMainProductList(completion: @escaping (([ProductEntities]) -> Void)) {
        do {
            let decoder = JSONDecoder()
            guard let bundle = Bundle.main.url(forResource: "product_list", withExtension: "json") else { return }
            let productData = try decoder.decode([ProductEntities].self, from: Data(contentsOf: bundle))
            completion(productData)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func fetchTransformDecimal(entity: [ProductEntities], at indexPath: IndexPath) -> String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        let result = decimalFormatter.string(from: NSNumber(value:entity[indexPath.item].productCost))! + "원"
        return result
    }
    
    func fetchTransformImage(entity: String) -> Data {
        //Transfrom String -> Data
        <#code#>
    }
    
    
    
    
    
}



