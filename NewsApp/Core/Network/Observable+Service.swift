//
//  Observable+Service.swift
//  NewsApp
//
//  Created by Morteza on 5/22/22.
//

import Foundation

extension Service {
    var toObservable: Observable<Result<Self.ResultType, Self.ErrorType>?> {
        let observable = Observable<Result<Self.ResultType, Self.ErrorType>?>(nil)
        let task = self.call { (result, done) in
            observable.value = result
        }
        task.start()
        return observable
    }
}

extension Result {
    var success: Success? {
        guard case let .success(value) = self else {
            return nil
        }
        return value
    }
}
