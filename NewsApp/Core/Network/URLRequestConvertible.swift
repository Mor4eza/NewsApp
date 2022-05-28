//
//  URLRequestConvertible.swift
//  NewsApp
//
//  Created by Morteza on 5/17/22.
//

import Foundation

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}
