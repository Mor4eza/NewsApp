//
//  API.swift
//  NewsApp
//
//  Created by Morteza on 5/15/22.
//

import Foundation

protocol API {
    func fetchContacts() -> Observable<Result<[Contact], RestError>?>
    func deleteContactFromServer(id: Int)
}

class ContactsApi: API {
    
    func fetchContacts() -> Observable<Result<[Contact], RestError>?> {
        return RestService(request: ContactRequest()).toObservable
        
    }
    
    func deleteContactFromServer(id: Int) {
        
    }
    
}
