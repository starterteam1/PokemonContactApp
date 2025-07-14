//
//  CoreDataManage.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/11/25.
//

import UIKit
import CoreData

final class CoreDataManage {
    
    var container: NSPersistentContainer!
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
    }
    
    func createData(image: Data?, name: String, phoneNumber: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: ContactEntity.className, in: self.container.viewContext) else { return }
        let newContactEntity = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newContactEntity.setValue(image, forKey: ContactEntity.Key.image)
        newContactEntity.setValue(name, forKey: ContactEntity.Key.name)
        newContactEntity.setValue(phoneNumber, forKey: ContactEntity.Key.phoneNumber)

        do {
            try self.container.viewContext.save()
            print("생성 성공")
        } catch {
            print("문맥 저장 실패")
        }
    }
    
    func readAllData() -> [ContactModel] {
        do {
            let request: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            let entities = try container.viewContext.fetch(request)

            return entities.map {
                ContactModel(
                    id: $0.objectID, image: $0.image ?? Data(), name: $0.name ?? "", phoneNumber: $0.phoneNumber ?? "")
            }

        } catch {
            print("데이터 읽기 실패")
            return []
        }
    }
    
    func updateData(id: NSManagedObjectID, name: String, phoneNumber: String, image: Data?) {
        do {
            let object = try container.viewContext.existingObject(with: id)
            object.setValue(name, forKey: ContactEntity.Key.name)
            object.setValue(phoneNumber, forKey: ContactEntity.Key.phoneNumber)
            object.setValue(image, forKey: ContactEntity.Key.image)

            try container.viewContext.save()
            print("업데이트 성공")
        } catch {
            print("업데이트 실패: \(error.localizedDescription)")
        }
    }
    
    
}
