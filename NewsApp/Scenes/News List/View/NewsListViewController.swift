    //
    //  NewsListViewController.swift
    //  NewsApp
    //
    //  Created by Morteza on 4/14/22.
    //

import UIKit

class NewsListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var viewModel: MainViewModel?
    var news: [Int] = [] {
        didSet {
            newsTableView.reloadData()
        }
    }
    var coordinator: NewsCoordinator?
    
    var loadingView: UIActivityIndicatorView = {
        let actIndicator = UIActivityIndicatorView()
        actIndicator.translatesAutoresizingMaskIntoConstraints = false
        actIndicator.style = .large
        return actIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        viewModel = MainViewModel()
        viewModel?.delegate = self
        viewModel?.fetchData()
    }
    
    func setupView() {
        self.view.addSubview(loadingView)
        let loadingViewAnchors = [loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                  loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)]
        NSLayoutConstraint.activate(loadingViewAnchors)
        loadingView.startAnimating()
    }
    
    private func setupTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "\(news[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator = NewsCoordinator(navigationController: self.navigationController!)
        coordinator?.getNewsDetail(with: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension NewsListViewController: MainViewModelDelegate {
    func didFetchNews(news: [Int]) {
        self.loadingView.stopAnimating()
        self.news = news
    }
    
    func didGetError(error: Error) {
        DispatchQueue.main.async {
            self.loadingView.stopAnimating()
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
