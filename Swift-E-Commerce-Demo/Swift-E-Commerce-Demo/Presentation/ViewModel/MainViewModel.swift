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
    var items: Observable<MainEntity> {get}
    var isEmpty: Bool {get}
}


final class MainViewModel: MainViewModelInput, MainViewModelOutput{
    
    //MARK: - OUTPUT

    let disposeBag: DisposeBag = DisposeBag()
    private let actions: MainViewModelAction?
    private let mainUseCase: MainUseCase
    let items: Observable<MainEntity>
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
        self.items = mainUseCase.execute()
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
        items
            .asObservable()
            .filter{$0.info.isEmpty}
            .subscribe { event in
                self.productItems = event.element?.info ?? []
                self.numberOfItemsInSection = event.element?.info.count ?? 0
            }.disposed(by: disposeBag)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        actions?.showDetailView(productItems[indexPath.item])
    }
    
    
}
