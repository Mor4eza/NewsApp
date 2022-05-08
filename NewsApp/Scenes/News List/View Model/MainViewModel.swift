//
//  MainViewModel.swift
//  NewsApp
//
//  Created by Morteza on 4/14/22.
//

import Foundation

protocol MainViewModelDelegate {
    func didFetchNews(news: [Int])
    func didGetError(error: Error)
}

class MainViewModel {
    
    var delegate: MainViewModelDelegate?
    
    func fetchData() {
        let newsRequest = NewsRequest()
        Network().request(req: newsRequest) { [self] result in
            switch result {
                case .success(let news):
                    print(news)
                    
                    delegate?.didFetchNews(news: news)
                case .failure(let error):
                    delegate?.didGetError(error: error)
//                
                    print("Error==>" + error.localizedDescription)
            }
        }
    }
    
}
