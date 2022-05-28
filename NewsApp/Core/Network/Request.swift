//
//  Requstable.swift
//  NewsApp
//
//  Created by Morteza on 4/14/22.
//

import Foundation
protocol Request: URLRequestConvertible, Cachable {
    associatedtype ResultType: Decodable
}
