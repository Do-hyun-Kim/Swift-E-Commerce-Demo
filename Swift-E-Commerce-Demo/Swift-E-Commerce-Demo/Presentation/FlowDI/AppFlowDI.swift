//
//  AppFlowDI.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/17.
//

import UIKit

protocol PresenterDI {
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator
    func makeMainViewController(actions: MainViewModelAction) -> MainViewController
    func makeMainCoordinator(presenter: UINavigationController) -> MainCoordinator
    func makeMainViewModel(actions: MainViewModelAction) -> MainViewModel
    func makeDetailViewController() -> DetailViewController
}


class AppFlowDI: PresenterDI {
    
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator {
        let appCoordinator = AppCoordinator(window: window, flowDI: self)
        return appCoordinator
    }
    
    func makeMainViewController(actions: MainViewModelAction) -> MainViewController {
        let mainViewController = MainViewController(viewModel: makeMainViewModel(actions: actions))
        mainViewController.title = "상품 정보"
        return mainViewController
    }
    
    func makeMainCoordinator(presenter: UINavigationController) -> MainCoordinator {
        let mainCoordinator = MainCoordinator(presenter: presenter, flowDI: self)
        return mainCoordinator
    }
    
    func makeMainViewModel(actions: MainViewModelAction) -> MainViewModel {
        let mainViewModel = MainViewModel(actions: actions)
        return mainViewModel
    }
    
    func makeDetailViewController() -> DetailViewController {
        let detailViewController = DetailViewController()
        return detailViewController
    }
}
