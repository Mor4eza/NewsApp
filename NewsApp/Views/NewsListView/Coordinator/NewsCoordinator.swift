//
//  NewsCoordinator.swift
//  NewsApp
//
//  Created by Morteza on 4/15/22.
//

import UIKit

class NewsCoordinator: Coordinator {
    
    private var navigationController: UINavigationController
    
    private var newsListViewController: MainViewController?
    private var newsDetailCoordinator: NewsDetailCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let newsVC = MainViewController.instantiate()
        self.newsListViewController = newsVC
        navigationController.pushViewController(newsVC, animated: true)
    }
    
    func getNewsDetail(with id: Int) {
        let newsDetailCoordinator = NewsDetailCoordinator(navigationController: navigationController, newsID: id)
        self.newsDetailCoordinator = newsDetailCoordinator
        newsDetailCoordinator.start()
    }
    
    func dismiss() {
        newsListViewController?.dismiss(animated: true, completion: nil)
    }
}

