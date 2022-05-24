//
//  ProductHeaderView.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/24.
//

import UIKit


class ProductHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier: String = String(describing: self)
    
    private let bestProduct: UILabel = {
        $0.font = .boldSystemFont(ofSize: 11)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 1
        
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bestProduct)
        bestProduct.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
