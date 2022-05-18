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

protocol MainViewModelOutput {
    var items: BehaviorSubject<[ProductEntities]> {get}
    var isEmpty: Bool {get}
}


final class MainViewModel: MainViewModelInput, MainViewModelOutput{
    
    //MARK: - OUTPUT
    let items: BehaviorSubject<[ProductEntities]> = .init(value: [])
    private let actions: MainViewModelAction?
    private let mainUseCase: MainUseCase
    private var productItems: [ProductEntities] = []
    
    var isEmpty: Bool {
        return productItems.isEmpty
    }
    
    init(actions: MainViewModelAction, mainUseCase: MainUseCase) {
        self.actions = actions
        self.mainUseCase = mainUseCase
    }
    
}



extension MainViewModel {
    
    //MARK: - INPUT
    func didSelectItem(at indexPath: IndexPath) {
        actions?.showDetailView(productItems[indexPath.item])
    }
}
