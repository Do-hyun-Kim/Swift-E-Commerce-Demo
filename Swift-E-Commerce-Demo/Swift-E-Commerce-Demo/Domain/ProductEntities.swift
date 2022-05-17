//
//  ProductEntities.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/17.
//

import Foundation


struct ProductEntities: Codable {
    var productDivision: String
    var productName: String
    var productBrand: String
    var productImage: String
    var productCost: String
    var productPrice: String
    var productDiscount: String
    
    private enum CodingKeys: String, CodingKey {
        case productDivision = "t"
        case productName = "n"
        case productBrand = "b"
        case productImage = "i"
        case productCost = "op"
        case productPrice = "p"
        case productDiscount = "d"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productDivision = try values.decode(String.self, forKey: .productDivision)
        productName = try values.decode(String.self, forKey: .productName)
        productBrand = try values.decode(String.self, forKey: .productBrand)
        productImage = try values.decode(String.self, forKey: .productImage)
        productCost = try values.decode(String.self, forKey: .productCost)
        productPrice = try values.decode(String.self, forKey: .productPrice)
        productDiscount = try values.decode(String.self, forKey: .productDiscount)
    }
}
