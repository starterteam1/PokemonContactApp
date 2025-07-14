//
//  Contact+CoreDataProperties.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/10/25.
//
//

import Foundation
import CoreData


extension ContactEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactEntity> {
        return NSFetchRequest<ContactEntity>(entityName: "ContactEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var image: Data?

}

extension ContactEntity : Identifiable {

}
