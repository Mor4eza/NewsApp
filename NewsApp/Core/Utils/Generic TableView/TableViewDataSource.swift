//
//  TableViewDataSource.swift
//  NewsApp
//
//  Created by Morteza on 5/9/22.
//

import UIKit

protocol IndexPathIndexable {
    associatedtype ItemType
    
    func objectAtIndexPath(indexPath: NSIndexPath) -> ItemType
    func numberOfItemsInSection(section: Int) -> Int
}


class TableViewDataSource<T: IndexPathIndexable, C: TableViewCellConfigurable>: NSObject, UITableViewDataSource where T.ItemType == C.ItemType {
    let data: T
    
    init(data: T) {
        self.data = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = C.reuseIdentifierForIndexPath(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? C.CellType else {
            fatalError("Cells with reuse identifier \(reuseIdentifier) not of type \(C.CellType.self)")
        }
        let item = data.objectAtIndexPath(indexPath: indexPath as NSIndexPath)
        C.configureCellAtIndexPath(indexPath: indexPath, item: item, cell: cell)
        return cell
    }
    
}
