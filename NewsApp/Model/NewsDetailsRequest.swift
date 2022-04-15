//
//  NewsDetailsRequest.swift
//  NewsApp
//
//  Created by Morteza on 4/15/22.
//

import Foundation

class NewsDetailsRequest: Requstable {
    typealias responseType = News
    
    var id: Int
    
    var path: String {
        "/v0/item/\(id).json"
    }
    
    init(id: Int) {
        self.id = id
    }
}
