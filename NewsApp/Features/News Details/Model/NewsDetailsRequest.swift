//
//  NewsDetailsRequest.swift
//  NewsApp
//
//  Created by Morteza on 4/15/22.
//

import Foundation

class NewsDetailsRequest: Requstable {
    typealias responseType = Article
    
    var id: Int
    
    var path: String {
        "/detail"
    }
    
    init(id: Int) {
        self.id = id
    }
}
