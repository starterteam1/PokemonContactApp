//
//  ContactModel.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/11/25.
//

import Foundation
import CoreData

struct ContactModel {
    let id: NSManagedObjectID
    let image: Data?
    let name: String
    let phoneNumber: String
}
