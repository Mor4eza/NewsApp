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
        newsListCoordinator = NewsCoordinator(navigationController: navigatioController)
    }
    
    func start() {
        newsListCoordinator?.start()
        window.rootViewController = navigatioController
        window.makeKeyAndVisible()
    }
}
