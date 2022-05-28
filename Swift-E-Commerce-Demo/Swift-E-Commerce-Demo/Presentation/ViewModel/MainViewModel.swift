//
//  MainViewModel.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/17.
//

import Foundation
import RxSwift


struct MainViewModelAction {
    let showDetailView: (ProductEntities) -> Void
}

protocol MainViewModelInput {
    func didSelectItem(at indexPath: IndexPath)
}

//최고가,최저가 Item 합친다
protocol MainViewModelOutput {
    func numberOfSections() -> Int
    var costFilterItems: BehaviorSubject<[Int]> { get set }
}


final class MainViewModel: MainViewModelInput, MainViewModelOutput{
    
    //MARK: - OUTPUT

    let disposeBag: DisposeBag = DisposeBag()
    private let actions: MainViewModelAction?
    private let mainUseCase: MainUseCase
    public var productItems: MainEntity?
    public var costFilterItems: BehaviorSubject<[Int]> = BehaviorSubject<[Int]>(value: [])
    
    //MARK: Obsservable Entiy

    
    enum MainSection: CaseIterable {
        case banner
        case product
    }
    
    init(actions: MainViewModelAction, mainUseCase: MainUseCase) {
        self.actions = actions
        self.mainUseCase = mainUseCase
        
        mainUseCase.execute()
            .subscribe { event in
                self.productItems = event.element
            }.disposed(by: disposeBag)
    }
    
    public func setDecimalCost(at indexPath: IndexPath) -> String {
        return mainUseCase.executeDecimalCost(entity: productItems!.info[indexPath.item].productCost)
    }
    
    public func setTransformImage(at indexPath: IndexPath, completion: @escaping(Data) -> Void ) {
        mainUseCase.executeImageData(entity: productItems!.info[indexPath.item].productImage)
            .asObservable()
            .subscribe { event in
                completion(event.element ?? Data())
            }.disposed(by: disposeBag)
    }
    
    public func numberOfItemsInSection(section: Int) -> Int {
        switch MainSection.allCases[section] {
        case .banner:
            return productItems?.banner_Info.count ?? 0
        case .product:
            return productItems?.info.count ?? 0
        }
    }
    
}



extension MainViewModel {
    
    //MARK: - INPUT
    
    func numberOfSections() -> Int {
        return MainSection.allCases.count
    }
    
    //MARK: - OUTPUT
    func didSelectItem(at indexPath: IndexPath) {
        actions?.showDetailView(productItems!.info[indexPath.item])
    }
    
    
}
