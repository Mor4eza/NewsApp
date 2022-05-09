//
//  Array+Indexable.swift
//  NewsApp
//
//  Created by Morteza on 5/9/22.
//

import Foundation

extension Array: IndexPathIndexable {
    
    func objectAtIndexPath(indexPath: NSIndexPath) -> Element {
        return self[indexPath.item]
    }
    
    
    func numberOfItemsInSection(section: Int) -> Int {
        return count
    }
}
