//
//  Requstable.swift
//  NewsApp
//
//  Created by Morteza on 4/14/22.
//

import Foundation
protocol Requstable {
    associatedtype responseType: Codable
    
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: [String: Any] {get}
}

extension Requstable {
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String: Any] {
        ["":""]
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
