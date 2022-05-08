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
        "?q=\(query)&from=2022-05-08&sortBy=popularity&apiKey=\(Constants.API_Key)"
    }
    
    init(query: String) {
        self.query = query
    }
}
