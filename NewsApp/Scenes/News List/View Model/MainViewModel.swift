//
//  MainViewModel.swift
//  NewsApp
//
//  Created by Morteza on 4/14/22.
//

import Foundation

class MainViewModel {
    var news: Observable<NewsList?> = Observable(nil)
    var FetchError: Observable<NetworkError?> = Observable(nil)
    
    func fetchData() {
        let newsRequest = NewsRequest(query: "Apple")
        Network().request(req: newsRequest) { [self] result in
            switch result {
                case .success(let news):
                    self.news.value = news
                case .failure(let error):
                    FetchError.value = error
                    print("Error==>" + error.localizedDescription)
            }
        }
    }
    
}
