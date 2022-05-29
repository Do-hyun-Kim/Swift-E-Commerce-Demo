//
//  MainRepository.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/18.
//

import Foundation
import RxSwift

protocol MainRepository {
    func fetchMainProductList() -> Observable<MainEntity>
    func fetchTransformDecimal(entity: Int) -> String
    func fetchTransformImage(entity: String) -> Observable<Data>
    func fetchLowerPrice(entity: [ProductEntities]) -> Observable<[Int]>
}

final class DefaultMainRepository: MainRepository {
    
    func fetchMainProductList() -> Observable<MainEntity> {
        return Observable<MainEntity>.create { observer in
            do {
                let decoder = JSONDecoder()
                if let bundle = Bundle.main.url(forResource: "product_list", withExtension: "json") {
                    let productData = try decoder.decode(MainEntity.self, from: Data(contentsOf: bundle))
                    observer.onNext(productData)
                }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func fetchTransformDecimal(entity: Int) -> String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        let result = decimalFormatter.string(from: NSNumber(value: entity))! + "원"
        return result
    }
    
    func fetchTransformImage(entity: String) -> Observable<Data> {
        return Observable<Data>.create { [weak self] observer in
            self?.transformData(entity: entity) { data in
                observer.onNext(data)
            }
            return Disposables.create()
        }
    }
    
    func fetchLowerPrice(entity: [ProductEntities]) -> Observable<[Int]> {
        let lowerEntity: [Int] = entity
            .map{$0.productCost}
            .sorted{ $0 < $1}
    
        return Observable.create { observer in
            observer.onNext(lowerEntity)
            return Disposables.create()
        }
            
    }
    
    
    private func transformData(entity: String, completion: @escaping(Data) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url: URL = URL(string: entity) else { return }
            let urlRequest: URLRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    completion(data)
                    return
                }
                debugPrint(error?.localizedDescription as Any)
            }.resume()
        }
        
    }
    
    
}



