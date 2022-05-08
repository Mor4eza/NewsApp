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
            newsTableView.reloadData()
        }
    }
    var coordinator: NewsListCoordinator?
    
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
        
        cell.textLabel?.text = news[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator = NewsListCoordinator(navigationController: self.navigationController!)
        coordinator?.getNewsDetail(with: indexPath.row)
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
