//
//  BannerCollectionViewCell.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/24.
//

import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    //MARK: Property
    static let reuseIdentifier: String = String(describing: self)
    
    private let bannerCountLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 9)
        return $0
    }(UILabel())
    
    private let bannerCountView: UIView = {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        
        return $0
    }(UIView())
    
    private let bannerImage: UIImageView = {
        $0.contentMode = .scaleToFill
        
        return $0
    }(UIImageView())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        autoLayoutConfigure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        
        [bannerImage,bannerCountView].forEach {
            addSubview($0)
        }
        
        bannerCountView.addSubview(bannerCountLabel)
    }
    
    private func autoLayoutConfigure() {
        
        bannerImage.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        bannerCountView.snp.makeConstraints {
            $0.bottom.equalTo(self).offset(-15)
            $0.right.equalTo(self).offset(-15)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
        
        bannerCountLabel.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    public func bindBannerCell(viewModel: MainViewModel, at indexPath: IndexPath) {
        DispatchQueue.main.async {
            do {
                let data = try Data(contentsOf: URL(string: (viewModel.productItems?.banner_Info[indexPath.item])!)!)
                print("Data : \(data)")
                self.bannerImage.image = UIImage(data: data)
            } catch  {
                print(error.localizedDescription)
            }
        }
        
    }
}

