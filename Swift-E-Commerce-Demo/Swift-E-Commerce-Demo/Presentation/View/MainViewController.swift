//
//  MainViewController.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/17.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    private var viewModel: MainViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(
            frame: .zero , collectionViewLayout: UICollectionViewCompositionalLayout { section, env -> NSCollectionLayoutSection? in
                switch MainViewModel.MainSection.allCases[section] {
                case .Banner:
                    return self.getLayoutBannerSection()
                case .Product:
                    return self.getLayoutRecommendProductSection()
                }
            })
        
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.isScrollEnabled = true
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .white
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }


    private func configure() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        viewModel.viewDidload()
    }
    
    
    private func getLayoutBannerSection() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalHeight(1),
            heightDimension: .fractionalHeight(200)
        )
        
        //item
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .zero
        
        //group
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup(layoutSize: itemSize)
        
        //section
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func getLayoutRecommendProductSection() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)
        )
        
        //item
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        //group
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(1.0/4.0)
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup(layoutSize: groupSize)
        
        //header
        let headerSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(40)
        )
        
        let header: NSCollectionLayoutBoundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        //section
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}



extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell()}
    
        cell.bindCell(viewModel: viewModel, at: indexPath)
        
        return cell
    }
}
