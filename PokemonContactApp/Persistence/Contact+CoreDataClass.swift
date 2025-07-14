//
//  Contact+CoreDataClass.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/10/25.
//
//

import Foundation
import CoreData

@objc(ContactEntity)
public class ContactEntity: NSManagedObject {
    public static let className: String = "ContactEntity"
    public enum Key {
        static let image = "image"
        static let name = "name"
        static let phoneNumber = "phoneNumber"
    }
}
