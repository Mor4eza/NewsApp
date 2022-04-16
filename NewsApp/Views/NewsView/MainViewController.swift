    //
    //  ViewController.swift
    //  NewsApp
    //
    //  Created by Morteza on 4/14/22.
    //

import UIKit

class MainViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var newsTableView: UITableView!
    var viewModel: MainViewModel?
    var news: [Int] = [] {
        didSet {
            newsTableView.reloadData()
        }
    }
    
    var coordinator: NewsCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel = MainViewModel()
        viewModel?.delegate = self
        viewModel?.fetchData()
    }
    
    private func setupTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
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
    }
    
}

extension MainViewController: MainViewModelDelegate {
    func didFetchNews(news: [Int]) {
        self.news = news
    }
    
    func didGetError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    
}
