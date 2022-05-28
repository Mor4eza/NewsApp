//
//  ContactsViewModel.swift
//  NewsApp
//
//  Created by Morteza on 5/10/22.
//

import Foundation

class ContactsViewModel {
    
    var contacts: Observable<[Contact]> = Observable([])
    var coordinator: ContactsCoordinator
    let api: API
    
    init(coordinator: ContactsCoordinator, api: API = ContactsApi()) {
        self.coordinator = coordinator
        self.api = api
    }
    
    func getContacts() -> Observable<Result<[Contact], RestError>?> {
        return api.fetchContacts()
    }

    func getContactsData() {
      getContacts().addEventHandler({ [weak self] result in
            switch result.newValue {
            case .success(let contacts):
                self?.contacts.value = contacts
            case .failure(let error):
                print(error)
            case .none:
                break
            }
        })
    }
}

//extension ContactsViewModel {
//
//    func fetchContacts() {
//
//        NetworkClient().call(req: ContactRequest()) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//                case .success(let users):
//                    self.contacts.value = users
//
//                case .failure(let error):
//                    self.networkError.value = error
//            }
//        }
//    }
//}
