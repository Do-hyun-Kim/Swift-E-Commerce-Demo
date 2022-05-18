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
    func didSelectItem(at index: IndexPath)
}

protocol MainViewModelOutput {
    var items: BehaviorSubject<[ProductEntities]> {get}
}


final class MainViewModel: MainViewModelInput, MainViewModelOutput{
    
    //MARK: - OUTPUT
    let items: BehaviorSubject<[ProductEntities]> = .init(value: [])
    private let actions: MainViewModelAction?
    
    init(actions: MainViewModelAction) {
        self.actions = actions
    }
    
}



extension MainViewModel {
    
    //MARK: - INPUT
    func didSelectItem(at index: IndexPath) {
        
    }
}
