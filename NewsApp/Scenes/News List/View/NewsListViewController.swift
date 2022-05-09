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
    var news: [Article] = [] {
        didSet {
            self.newsDataSource = TableViewDataSource(data: self.news)
            self.newsTableView.dataSource = self.newsDataSource
            newsTableView.reloadData()
        }
    }
    var coordinator: NewsListCoordinator?
    var newsDataSource: TableViewDataSource<[Article], NewsTableViewCell>?
    
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
        viewModel?.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        binding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unobserveAll()
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
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        
    }
    
}

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator = NewsListCoordinator(navigationController: self.navigationController!)
        coordinator?.getNewsDetail(with: 12555)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension NewsListViewController {
    
    func binding() {
        viewModel?.news.addEventHandler({ [weak self] newsList in
            self?.loadingView.stopAnimating()
            self?.news = newsList.newValue!.articles
        })
        
            // Error Binding
        viewModel?.FetchError.addEventHandler({ [weak self] error in
            DispatchQueue.main.async {
                self?.loadingView.stopAnimating()
                self?.coordinator?.showAlert(title: "Error", desc: error.newValue!.localizedDescription)
            }
        })
    }
    
    
}
