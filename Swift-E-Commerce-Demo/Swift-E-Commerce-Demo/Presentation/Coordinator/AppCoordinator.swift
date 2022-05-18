//
//  AppCoordinator.swift
//  Swift-E-Commerce-Demo
//
//  Created by Kim dohyun on 2022/05/17.
//

import UIKit

protocol Coordinator {
    var presenter: UINavigationController {get set}
    var childrenCoordinator: [Coordinator] {get set}
    func start()
}


final class AppCoordinator: Coordinator {
    
    //MARK: Property
    var presenter: UINavigationController
    var childrenCoordinator: [Coordinator]
    var window: UIWindow
    var flowDI: PresenterDI
    
    init(window: UIWindow, flowDI: PresenterDI){
        self.window = window
        self.presenter = UINavigationController()
        self.flowDI = flowDI
        self.childrenCoordinator = []
    }
    
    func start() {
        showMainVC()
        self.window.rootViewController = presenter
        self.window.makeKeyAndVisible()
    }
    
    func showMainVC() {
        let mainCoordinator = flowDI.makeMainCoordinator(presenter: presenter)
        presenter.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        mainCoordinator.start()
        self.childrenCoordinator.append(mainCoordinator)
    }
    
}


final class MainCoordinator: Coordinator {
    
    //MARK: Property
    var presenter: UINavigationController
    var childrenCoordinator: [Coordinator]
    var flowDI: PresenterDI
    
    init(presenter: UINavigationController, flowDI: AppFlowDI) {
        self.presenter = presenter
        self.flowDI = flowDI
        self.childrenCoordinator = []
    }
    
    func start() {
        let actions = MainViewModelAction(showDetailView: showDetailView)
        let mainVC = flowDI.makeMainViewController(actions: actions)
        self.presenter.pushViewController(mainVC, animated: true)
        
    }
    
    func showDetailView(product: ProductEntities) {
        let detailVC = flowDI.makeDetailViewController()
        self.presenter.pushViewController(detailVC, animated: true)
    }
}
