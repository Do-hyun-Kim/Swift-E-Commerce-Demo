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
    func viewDidload()
    func didSelectItem(at indexPath: IndexPath)
    func numberOfSections() -> Int
}

protocol MainViewModelOutput {
    var items: BehaviorSubject<[ProductEntities]> {get}
    var isEmpty: Bool {get}
}


final class MainViewModel: MainViewModelInput, MainViewModelOutput{
    
    //MARK: - OUTPUT
    let items: BehaviorSubject<[ProductEntities]> = BehaviorSubject(value: [])
    
    let disposeBag: DisposeBag = DisposeBag()
    private let actions: MainViewModelAction?
    private let mainUseCase: MainUseCase
    private var productItems: [ProductEntities] = []
    
    var isEmpty: Bool {
        return productItems.isEmpty
    }
    
    enum MainSection: CaseIterable {
        case Banner
        case Product
    }
    public var numberOfItemsInSection: Int = 0
    
    init(actions: MainViewModelAction, mainUseCase: MainUseCase) {
        self.actions = actions
        self.mainUseCase = mainUseCase
        
        items
            .subscribe { value in
                self.productItems = value.element ?? []
                self.numberOfItemsInSection = value.element?.count ?? 0
            }.disposed(by: disposeBag)
        
    }
    
    public func setDecimalCost(at indexPath: IndexPath) -> String {
        return mainUseCase.executeDecimalCost(entity: productItems[indexPath.item].productCost)
    }
    
    public func setTransformImage(at indexPath: IndexPath, completion: @escaping(Data) -> Void ) {
        mainUseCase.executeImageData(entity: productItems[indexPath.item].productImage)
            .asObservable()
            .subscribe { event in
                completion(event.element ?? Data())
            }.disposed(by: disposeBag)
    }
    
}



extension MainViewModel {
    
    //MARK: - INPUT
    
    func numberOfSections() -> Int {
        return MainSection.allCases.count
    }
    
    func viewDidload() {
        mainUseCase.execute { [weak self] result in
            self?.items.onNext(result)
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        actions?.showDetailView(productItems[indexPath.item])
    }
    
    
}
