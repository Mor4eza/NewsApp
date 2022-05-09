    //
    //  DetailsViewController.swift
    //  NewsApp
    //
    //  Created by Morteza on 4/14/22.
    //

import UIKit
import WebKit

class DetailsViewController: UIViewController, Storyboarded, WKNavigationDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var newsID: Int?
    var news: Article? {
        didSet {
            updateUI()
        }
    }
    
    var viewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News Detail"
        
        guard let newsID = newsID else {
            return
        }
        
        webView.navigationDelegate = self
        viewModel.fetchNewsDetails(id: newsID)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        binding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unobserveAll()
    }
    
    private func updateUI() {
        guard let news = news, let url = URL(string: news.url) else {
            return
        }
        
        self.titleLabel.text = news.title
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust  else {
            completionHandler(.useCredential, nil)
            return
        }
        let credential = URLCredential(trust: serverTrust)
        completionHandler(.useCredential, credential)
        
    }
}

extension DetailsViewController {
    
    func binding() {
        viewModel.article.addEventHandler { [weak self] article in
            self?.news = article.newValue
        }
        
        viewModel.FetchError.addEventHandler { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: error.newValue?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default,handler: { _ in
                    self?.navigationController?.popViewController(animated: true)
                }))
                self?.navigationController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
