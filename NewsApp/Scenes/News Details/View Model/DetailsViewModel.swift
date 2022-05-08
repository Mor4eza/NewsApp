//
//  DetailsViewModel.swift
//  NewsApp
//
//  Created by Morteza on 4/15/22.
//

import Foundation

protocol DetailsViewModelDelegate {
    func didFetchNewsDetails(news: News)
    func didGetError(error: Error)
}

class DetailsViewModel {
    
    var delegate: DetailsViewModelDelegate?
    
    func fetchNewsDetails(id: Int) {
        let newsDetailsRequest = NewsDetailsRequest(id: id)
        Network().request(req: newsDetailsRequest) { result in
            switch result {
                case .success(let news):
                    self.delegate?.didFetchNewsDetails(news: news)
                case .failure(let error):
                    self.delegate?.didGetError(error: error)
            }
        }
    }
}
