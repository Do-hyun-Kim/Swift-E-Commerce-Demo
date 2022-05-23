//
//  BannerCollectionView.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/23.
//

import UIKit

protocol BannerFlow: AnyObject {
    func createCompositinalLayout() -> UICollectionViewCompositionalLayout
    func createItemLayout() -> NSCollectionLayoutItem
    func createGroupLayout() -> NSCollectionLayoutGroup
    func createSectionLayout() -> NSCollectionLayoutSection
}


class BannerCollectionView: BannerFlow {
    
    func createCompositinalLayout() -> UICollectionViewCompositionalLayout {
        let layout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout(section: createSectionLayout())
        
        return layout
    }
    
    func createItemLayout() -> NSCollectionLayoutItem {
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
        item.contentInsets = .zero
        
        return item
    }
    
    func createGroupLayout() -> NSCollectionLayoutGroup {
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitems: [createItemLayout()])
        group.contentInsets = .zero

        return group
    }
    
    func createSectionLayout() -> NSCollectionLayoutSection {
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: createGroupLayout())
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
}
