//
//  ProductHeaderView.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/24.
//

import UIKit
import SnapKit


class ProductHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier: String = String(describing: self)
    
    private let bestProduct: UILabel = {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.text = "당신을 위한 추천 아이템"
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bestProduct)
        bestProduct.snp.makeConstraints {
            $0.top.equalTo(self).offset(10)
            $0.width.equalToSuperview()
            $0.left.equalTo(self).offset(5)
            $0.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
