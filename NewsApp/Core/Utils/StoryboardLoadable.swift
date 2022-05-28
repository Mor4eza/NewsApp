//
//  StoryboardLoadable.swift
//  NewsApp
//
//  Created by Morteza on 4/15/22.
//

import UIKit

enum StoryBoard: String {
    case Main
    case Contacts
}

protocol StoryboardLoadable where Self: UIViewController {
    
        /// calculate storyboard identifier using viewController its description()
        /// Bundle.SplashScreenViewController -> SplashScreenViewController
    static var storybaordIdentifier: String {get}
    
        /// instantiate view controller using its id and removes the `ViewController` suffix and find a storyboard with the remaining name
        /// ``` SplashScreenViewController.instantiateFromStoryboard()
        ///        SplashScreenViewController ---create a new storyboard----> SplashScreen.storyboard ---find view controller by its id
        /// ```
    static func instantiateFromStoryboard() -> Self?
    
    static func instanstiateFrom(storyBoard: StoryBoard) -> Self?
}

extension StoryboardLoadable {
    static var storybaordIdentifier: String {
        Self.description().components(separatedBy: ".").last  ?? Self.description()
    }
    
    static func instantiateFromStoryboard() -> Self? {
        UIStoryboard(name: Self.storybaordIdentifier.replacingOccurrences(of: "ViewController", with: "") , bundle: nil).instantiateViewController(withIdentifier: Self.storybaordIdentifier) as? Self
    }
    
    static func instantiateFromViewController(viewController: UIViewController) -> Self? {
        UIStoryboard(name: String(describing: viewController.classForCoder).replacingOccurrences(of: "ViewController", with: "") , bundle: nil).instantiateViewController(withIdentifier: Self.storybaordIdentifier) as? Self

    }
    
    static func instanstiateFrom(storyBoard: StoryBoard = .Main) -> Self? {
        let id = String(describing: self.classForCoder())
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: id) as? Self
        
    }
}
