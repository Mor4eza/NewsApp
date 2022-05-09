//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Morteza on 5/9/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell, TableViewCellConfigurable {
    typealias ItemType = Article
    typealias CellType = NewsTableViewCell
    
    static var reuseIdentifier = "newsCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static func reuseIdentifierForIndexPath(indexPath: IndexPath) -> String {
        return reuseIdentifier
    }
    
    static func configureCellAtIndexPath(indexPath: IndexPath, item: ItemType, cell: CellType) {
        
        
        cell.titleLabel.text = item.title
    }
    
}
