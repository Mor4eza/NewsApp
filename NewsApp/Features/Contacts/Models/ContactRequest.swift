//
//  ContactRequest.swift
//  NewsApp
//
//  Created by Morteza on 5/15/22.
//

import Foundation

class ContactRequest: Request {
    typealias ResultType = [Contact]
    
    func asURLRequest() throws -> URLRequest {
        return URLRequest(url: URL(string: path)!)
    }
    
    var acceptCache: Bool = false
    var path: String {
        return Constants.baseURL + "users"
    }
}
