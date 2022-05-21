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
    private var imageData: Data?
    private var productItems: [ProductEntities] = []
    
    var isEmpty: Bool {
        return productItems.isEmpty
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
        return mainUseCase.executeDecimalCost(entity: productItems, at: indexPath)
    }
    
    public func setTransformImage(at indexPath: IndexPath) {
        mainUseCase.executeImageData(entity: productItems[indexPath.item].productImage)
            .asObservable()
            .subscribe { event in
                print("Image Data \(event.element)")
                self.imageData = event.element ?? Data()
            }.disposed(by: disposeBag)
    }
    
}



extension MainViewModel {
    
    //MARK: - INPUT
    
    func viewDidload() {
        mainUseCase.execute { [weak self] result in
            self?.items.onNext(result)
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        actions?.showDetailView(productItems[indexPath.item])
    }
    
    
}
