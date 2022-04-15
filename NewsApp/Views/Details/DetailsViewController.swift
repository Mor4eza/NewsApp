//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Morteza on 4/14/22.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var newsID: Int?
    var news: News? {
        didSet {
            updateUI()
        }
    }
    
    var viewModel = DetailsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News Detail"
        viewModel.delegate = self
        guard let newsID = newsID else {
            return
        }

        viewModel.fetchNewsDetails(id: newsID)
        
    }
    
    private func updateUI() {
        guard let news = news, let url = URL(string: news.url) else {
            return
        }

        self.titleLabel.text = news.title
        let request = URLRequest(url: url)
        self.webView.load(request)
    }

}

extension DetailsViewController: DetailsViewModelDelegate {
    
    func didFetchNewsDetails(news: News) {
        self.news = news
    }
    
    func didGetError(error: Error) {
        print("error")
    }
    
    
}
