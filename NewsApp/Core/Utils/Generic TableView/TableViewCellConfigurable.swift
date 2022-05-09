//
//  TableViewCellConfigurable.swift
//  NewsApp
//
//  Created by Morteza on 5/9/22.
//

import UIKit

protocol TableViewCellConfigurable {
    associatedtype ItemType
    associatedtype CellType: UITableViewCell
    
    static func reuseIdentifierForIndexPath(indexPath: IndexPath) -> String
    static func configureCellAtIndexPath(indexPath: IndexPath, item: ItemType, cell: CellType)
}
