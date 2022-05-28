//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Morteza on 4/15/22.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private var navigatioController: UINavigationController
    private var contactsCoordinator: ContactsCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        navigatioController = UINavigationController()
        start()
    }
    
    func start() {
        guard let contactVC = ContactsViewController.instantiateFromStoryboard() else { return }
        navigatioController = UINavigationController(rootViewController: contactVC)

        contactVC.viewModel = ContactsViewModel(coordinator: self, api: ContactsApi())

        window.rootViewController = navigatioController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: ContactsCoordinator {
    
    func load() {
        guard let contactVC = ContactsViewController.instantiateFromStoryboard() else { return }
        let viewModel = ContactsViewModel(coordinator: self)
        contactVC.viewModel = viewModel
        self.navigatioController.pushViewController(contactVC, animated: true)
    }
    
    func edit(contactId: Int) {
        guard let vc = EditContactViewController.instanstiateFrom(storyBoard: .Contacts) else { return }
        let viewModel = ContactsViewModel(coordinator: self)
        vc.viewModel = viewModel
        self.navigatioController.pushViewController(vc, animated: true)
    }
    
    func delete() {
        
    }
    
    func add() {
        guard let addVC = AddContactViewController.instanstiateFrom(storyBoard: .Contacts) else { return }
        self.navigatioController.pushViewController(addVC, animated: true)
    }
    
    
}
