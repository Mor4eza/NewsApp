//
//  Task.swift
//  NewsApp
//
//  Created by Morteza on 5/17/22.
//

import Foundation

protocol Task: AnyObject {
    func start()
    func stop()
}

extension URLSessionDataTask: Task {
    
    func start() {
        self.resume()
    }
    
    func stop() {
        self.cancel()
    }
    
}
