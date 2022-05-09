//
//  NewsRequest.swift
//  NewsApp
//
//  Created by Morteza on 4/14/22.
//

import Foundation

final class NewsRequest: Requstable {
    typealias responseType = NewsList
    
    var query: String = ""
    
    var path: String {
        "/trendig"
    }
    
    init(query: String) {
        self.query = query
    }
}
