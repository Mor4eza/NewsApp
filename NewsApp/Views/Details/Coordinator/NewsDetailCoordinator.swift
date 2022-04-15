//
//  NewsListCoordinator.swift
//  NewsApp
//
//  Created by Morteza on 4/15/22.
//

import Foundation
import UIKit

class NewsDetailCoordinator: Coordinator {
    
    private var navigationController: UINavigationController
    private var newsDetailsVC: DetailsViewController?

    private let newsID: Int
    
    init(navigationController: UINavigationController, newsID: Int) {
        self.navigationController = navigationController
        self.newsID = newsID
    }
    
    func start() {
        let newsDetailVC = DetailsViewController.instantiate()
        newsDetailVC.newsID = newsID
        self.newsDetailsVC = newsDetailVC
        navigationController.pushViewController(newsDetailVC, animated: true)
    }
    
}
