//
//  MainCollectionViewCell.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/19.
//

import UIKit
import RxSwift
import RxCocoa


class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: Property
    static let reuseIdentifier: String = String(describing: self)
    
    private var productImageView: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        
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
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        [productImageView,productBrandLabel,productNameLabel].forEach {
            addSubview($0)
        }
        
        self.backgroundColor = .systemPink
        productImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        productImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        productImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    public func bindCell(viewModel: MainViewModel, at indexPath: IndexPath) {
        print(viewModel.setDecimalCost(at: indexPath))
        viewModel.setTransformImage(at: indexPath) { [weak self] element in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.productImageView.image = UIImage(data: element)
            }
        }
    }
    
}
