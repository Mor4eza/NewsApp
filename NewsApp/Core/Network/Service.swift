//
//  Service.swift
//  NewsApp
//
//  Created by Morteza on 5/17/22.
//

import Foundation

protocol Service {
    associatedtype ResultType
    associatedtype ErrorType: Error
    @discardableResult
    func call(callback: @escaping (_ result: Result<ResultType, ErrorType>,_ isCompleted: Bool)-> Void) -> Task
}
