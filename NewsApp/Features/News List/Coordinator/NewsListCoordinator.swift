//
//  NewsCoordinator.swift
//  NewsApp
//
//  Created by Morteza on 4/15/22.
//

import UIKit

class NewsListCoordinator: Coordinator {
    
    private var navigationController: UINavigationController
    
    private var newsListViewController: NewsListViewController?
    private var newsDetailCoordinator: NewsDetailCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let newsVC = NewsListViewController.instantiate()
        self.newsListViewController = newsVC
        navigationController.pushViewController(newsVC, animated: true)
    }
    
    func addComment(id: Int, comment: String) {
        
    }
    
    func getNewsDetail(with id: Int) {
        let newsDetailCoordinator = NewsDetailCoordinator(navigationController: navigationController, newsID: id)
        self.newsDetailCoordinator = newsDetailCoordinator
        newsDetailCoordinator.start()
    }
    
    func showAlert(title: String, desc: String) {
        let alert = UIAlertController(title: title, message: desc, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.navigationController.present(alert, animated: true, completion: nil)
    }
    
    func dismiss() {
        newsListViewController?.dismiss(animated: true, completion: nil)
    }
}

