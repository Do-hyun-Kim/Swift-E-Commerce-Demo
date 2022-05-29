//
//  BannerFooterView.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/26.
//

import UIKit
import SnapKit


class BannerFooterView: UICollectionReusableView {
    
    private var contentView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = false
        $0.layer.shadowColor = UIColor.lightGray.cgColor
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowOffset = CGSize(width: 10, height: 0)
        return $0
    }(UIView())
    
    private var contentSubView: UIImageView = {
        $0.image = UIImage(named: "rightArrow")
        $0.contentMode = .scaleToFill
        $0.isUserInteractionEnabled = false
        return $0
    }(UIImageView())
    
    private var deliveryImageView: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named: "delivery")
        
        return $0
    }(UIImageView())
    
    private var contentLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.text = "무료배송, 빠른 도착"
        
        return $0
    }(UILabel())
    
    private var subTitleLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 11)
        $0.textColor = .gray
        $0.text = "밤 12시 전 주문 시, 내일(금) 도착"
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.shadowRadius = contentView.frame.height / 2
    }
    
    private func configure() {
        [contentView,contentLabel,subTitleLabel].forEach {
            addSubview($0)
        }
        
        [contentSubView,deliveryImageView].forEach {
            contentView.addSubview($0)
        }
        
        contentView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(15)
            $0.right.bottom.equalToSuperview().offset(-15)
        }
        
        contentSubView.snp.makeConstraints {
            $0.right.equalTo(contentView.snp.right).offset(-20)
            $0.centerY.equalTo(contentView)
            $0.width.height.equalTo(20)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView).offset(-15)
            $0.left.equalTo(contentView).offset(15)
            $0.width.lessThanOrEqualTo(contentView)
            $0.height.equalTo(10)
            
        }
        
        deliveryImageView.snp.makeConstraints {
            $0.left.equalTo(subTitleLabel)
            $0.bottom.equalTo(subTitleLabel.snp.top).offset(-10)
            $0.height.equalTo(20)
            $0.width.equalTo(90)
        }
        
        contentLabel.snp.makeConstraints {
            $0.left.equalTo(deliveryImageView.snp.right).offset(10)
            $0.centerY.equalTo(deliveryImageView)
            $0.height.equalTo(20)
            $0.width.lessThanOrEqualTo(contentView)
            
        }
    }
    
}
