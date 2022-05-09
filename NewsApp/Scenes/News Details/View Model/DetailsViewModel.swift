//
//  DetailsViewModel.swift
//  NewsApp
//
//  Created by Morteza on 4/15/22.
//

import Foundation

class DetailsViewModel {
    
    var article: Observable<Article?> = Observable(nil)
    var FetchError: Observable<NetworkError?> = Observable(nil)

    
    func fetchNewsDetails(id: Int) {
        let newsDetailsRequest = NewsDetailsRequest(id: id)
        Network().request(req: newsDetailsRequest) { [weak self] result in
            switch result {
                case .success(let news):
                    self?.article.value = news
                case .failure(let error):
                    self?.FetchError.value = error
            }
        }
    }
}
