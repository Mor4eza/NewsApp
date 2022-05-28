//
//  BaseResponse.swift
//  NewsApp
//
//  Created by Morteza on 5/17/22.
//

import Foundation

struct BaseResponse<T: Codable> {
    let statusCode: Int
    let message: String
    let response: [T]
}
