//
//  Storyboarded.swift
//  NewsApp
//
//  Created by Morteza on 4/15/22.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: Storyboard.Main.rawValue, bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}

enum Storyboard: String {
    case Main
}
