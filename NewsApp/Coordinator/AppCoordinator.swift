//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Morteza on 4/15/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigatioController: UINavigationController
    private var newsListCoordinator: NewsCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        navigatioController = UINavigationController()
        navigatioController.navigationBar.prefersLargeTitles = true
        navigatioController.navigationBar.barStyle = .black
        newsListCoordinator = NewsCoordinator(navigationController: navigatioController)
    }
    
    func start() {
        window.rootViewController = navigatioController
        newsListCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
