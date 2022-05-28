//
//  MainCollectionViewCell.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/19.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: Property
    static let reuseIdentifier: String = String(describing: self)
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var productImageView: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())
    
    private var productBrandLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 11)
        $0.textAlignment = .left
        $0.textColor = .black
        $0.numberOfLines = 1
        
        return $0
    }(UILabel())
    
    
    private var productNameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 11)
        $0.textColor = .black.withAlphaComponent(0.8)
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
        return $0
    }(UILabel())
    
    private var productDiscountLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 13)
        $0.textColor = .systemPink
        $0.numberOfLines = 1
        $0.textAlignment = .left
        
        return $0
    }(UILabel())
    
    private var productCostLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 13)
        $0.textColor = .black
        $0.numberOfLines = 1
        $0.textAlignment = .left
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
        [productImageView,productBrandLabel,productNameLabel,productDiscountLabel,productCostLabel].forEach {
            self.contentView.addSubview($0)
        }
        
        productImageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(130)
        }
        
        productBrandLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(10)
            $0.left.right.equalTo(productImageView)
            $0.height.equalTo(10)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(productBrandLabel.snp.bottom).offset(5)
            $0.left.right.equalTo(productBrandLabel)
            $0.height.equalTo(10)
        }
        
        productDiscountLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(3)
            $0.left.equalTo(productNameLabel)
            $0.height.equalTo(13)
        }
        
        productCostLabel.snp.makeConstraints {
            $0.top.equalTo(productDiscountLabel)
            $0.left.equalTo(productDiscountLabel.snp.right).offset(5)
            $0.height.equalTo(13)
        }
        
    }
    
    public func bindCell(viewModel: MainViewModel, at indexPath: IndexPath) {
        print(viewModel.setDecimalCost(at: indexPath))
        viewModel.setTransformImage(at: indexPath) { [weak self] element in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.productImageView.image = UIImage(data: element)
                self.productBrandLabel.text = viewModel.productItems!.info[indexPath.item].productBrand
                self.productNameLabel.text = viewModel.productItems?.info[indexPath.item].productName
                self.productDiscountLabel.text = "\(viewModel.productItems!.info[indexPath.item].productDiscount)%"
                self.productCostLabel.text = viewModel.setDecimalCost(at: indexPath)
                
                viewModel.costFilterItems
                    .subscribe { event in
                        print("Cost Filter Element \(event.element)")
                    }.disposed(by: self.disposeBag)
            }
        }
    }
    
}
