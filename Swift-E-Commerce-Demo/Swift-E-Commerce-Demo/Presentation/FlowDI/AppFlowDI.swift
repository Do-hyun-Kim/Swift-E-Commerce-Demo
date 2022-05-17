//
//  AppFlowDI.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/17.
//

import UIKit

protocol PresenterDI {
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator
    func makeMainViewController() -> MainViewController
    func makeMainCoordinator(presenter: UINavigationController) -> MainCoordinator
}


class AppFlowDI: PresenterDI {
    
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator {
        let appCoordinator = AppCoordinator(window: window, flowDI: self)
        return appCoordinator
    }
    
    func makeMainViewController() -> MainViewController {
        let mainViewController = MainViewController()
        mainViewController.title = "상품 정보"
        return mainViewController
    }
    
    func makeMainCoordinator(presenter: UINavigationController) -> MainCoordinator {
        let mainCoordinator = MainCoordinator(presenter: presenter, flowDI: self)
        return mainCoordinator
    }
}
