//
//  ContactListViewModel.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/11/25.
//

import Foundation


final class ContactListViewModel {
    
    private let coreDataManage = CoreDataManage()
    
    private(set) var contacts: [ContactModel] = []
    
    func reloadCell() {
        contacts = coreDataManage.readAllData()
    }
    
    func contact(at index: Int) -> ContactModel {
        return contacts[index]
    }
    
    var count: Int {
        return contacts.count
    }
}
