//
//  NewsRequest.swift
//  NewsApp
//
//  Created by Morteza on 4/14/22.
//

import Foundation

final class NewsRequest: Requstable {
    typealias responseType = [Int]
    
    var path: String {
        "/v0/topstories.json?print=pretty"
    }

}
