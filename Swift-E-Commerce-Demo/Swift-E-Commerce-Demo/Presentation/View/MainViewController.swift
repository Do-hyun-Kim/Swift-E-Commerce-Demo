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
        let collectionView: UICollectionView = UICollectionView(frame: .zero)
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
        
        viewModel.viewDidload {
            viewModel.items
                .withUnretained(self)
                .subscribe { (vc, _) in
                    vc.collectionView.reloadData()
                }.disposed(by: disposeBag)
        }
    }
}

