//
//  ContactCell.swift
//  NewsApp
//
//  Created by Morteza on 5/22/22.
//

import UIKit

class ContactCell: UITableViewCell, TableViewCellConfigurable {

    
    typealias CellType = ContactCell
    typealias ItemType = Contact

    static var reuseIdentifier = "HomeCVCell"

    @IBOutlet weak var titleLabel: UILabel!

    static func reuseIdentifierForIndexPath(indexPath: IndexPath) -> String {
        reuseIdentifier
    }
    
    static func configureCellAtIndexPath(indexPath: IndexPath, item: Contact, cell: ContactCell) {
        cell.titleLabel.text = item.name
    }
    
    
}
