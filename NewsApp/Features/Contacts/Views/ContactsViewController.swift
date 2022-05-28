//
//  ContactsViewController.swift
//  NewsApp
//
//  Created by Morteza on 5/10/22.
//

import UIKit

class ContactsViewController: UIViewController, StoryboardLoadable {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ContactsViewModel?
    var contactDataSource: TableViewDataSource<[Contact], ContactCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        title = "Contacts"
        viewModel?.getContactsData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: ContactCell.reuseIdentifier)
        tableView.delegate = self
    }
    
    func binding() {
        viewModel?.contacts.addEventHandler({ contacts in
            DispatchQueue.main.async { [weak self] in
                self?.contactDataSource = TableViewDataSource(data: self?.viewModel?.contacts.value ?? [])
                self?.tableView.dataSource = self?.contactDataSource
                self?.tableView.reloadData()

            }
        })
        
//        contacts.addEventHandler { contacts in
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        binding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unobserveAll()
    }
    
}

// MARK: - Table view data source
extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertSheet = UIAlertController(title: "Options", message: "Select An Option", preferredStyle: .actionSheet)
        
        alertSheet.addAction(UIAlertAction(title: "Add Contact", style: .default, handler: { _ in
            self.viewModel?.coordinator.add()
        }))
        
        alertSheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            self.viewModel?.coordinator.edit(contactId: indexPath.row)
        }))
        
        alertSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            print("delete")
        }))
        
        alertSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertSheet, animated: true, completion: nil)
    }
    
}
