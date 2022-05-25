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
    func makeMainUseCase() -> MainUseCase
    func makeMainRepository() -> MainRepository
}


class AppFlowDI: PresenterDI {
    
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator {
        let appCoordinator = AppCoordinator(window: window, flowDI: self)
        return appCoordinator
    }
    
    func makeMainViewController(actions: MainViewModelAction) -> MainViewController {
        let mainViewController = MainViewController(viewModel: makeMainViewModel(actions: actions))
        let logoImage: UIImage = UIImage(named: "zigzagLogo") ?? UIImage()
        mainViewController.navigationItem.titleView = UIImageView(image: logoImage)
        return mainViewController
    }
    
    func makeMainCoordinator(presenter: UINavigationController) -> MainCoordinator {
        let mainCoordinator = MainCoordinator(presenter: presenter, flowDI: self)
        return mainCoordinator
    }
    
    func makeMainViewModel(actions: MainViewModelAction) -> MainViewModel {
        let mainViewModel = MainViewModel(actions: actions, mainUseCase: makeMainUseCase())
        return mainViewModel
    }
    
    func makeMainUseCase() -> MainUseCase {
        let mainUseCase = DefaultMainUseCase(mainRepository: makeMainRepository())
        return mainUseCase
    }
    
    func makeMainRepository() -> MainRepository {
        let mainRepository = DefaultMainRepository()
        return mainRepository
    }
    
    func makeDetailViewController() -> DetailViewController {
        let detailViewController = DetailViewController()
        return detailViewController
    }
}
