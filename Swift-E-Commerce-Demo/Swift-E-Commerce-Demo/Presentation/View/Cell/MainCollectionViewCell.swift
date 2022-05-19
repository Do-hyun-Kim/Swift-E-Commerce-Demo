//
//  MainCollectionViewCell.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/19.
//

import UIKit


class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: Property
    static let reuseIdentifier: String = String(describing: self)
    
    private var productImageView: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
        
        return $0
    }(UIImageView())
    
    private var productBrandLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 8)
        $0.textAlignment = .left
        $0.textColor = .black
        $0.numberOfLines = 1
        
        return $0
    }(UILabel())
    
    
    private var productNameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 8)
        $0.textAlignment = .left
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private var productCostLabel: UILabel = {
        
        
        
        return $0
    }(UILabel())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        [productImageView,productBrandLabel,productNameLabel].forEach {
            addSubview($0)
        }
    }
    
    public func bindCell(viewModel: MainViewModel, at indexPath: IndexPath) {
        print(viewModel.setDecimalCost(at: indexPath))
        
    }
    
}
