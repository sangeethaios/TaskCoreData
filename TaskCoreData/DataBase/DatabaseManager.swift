//
//  DatabaseManager.swift
//  TaskCoreData
//
//  Created by SangeethaKalis on 29/04/24.
//

import Foundation
import CoreData
import UIKit

class DatabaseManager {
    static let shared = DatabaseManager()
    private init() {}
    var userDatasres: UserDatas?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskCoreData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveUserData(name: String, gender: String, email: String, mobile: String) {
        let context = persistentContainer.viewContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "UserData", in: context) else { return }
        let userData = NSManagedObject(entity: entityDescription, insertInto: context)
        userData.setValue(name, forKey: "name")
        userData.setValue(gender, forKey: "gender")
        userData.setValue(email, forKey: "email")
        userData.setValue(mobile, forKey: "mobile")

        
        do {
            try context.save()
        } catch {
            print("Failed saving: \(error)")
        }
    }
    func updateUserData(name: String, gender: String, email: String, mobile: String) {
        guard let userData = userDatasres else {
            print("Error: No user data to update")
            return
        }

        // Get a reference to the managed object context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error: Unable to get AppDelegate")
            return
        }
        let context = appDelegate.persistentContainer.viewContext

        // Fetch the existing user entity from Core Data
        let fetchRequest: NSFetchRequest<UserData> = NSFetchRequest<UserData>(entityName: "UserData")
        fetchRequest.predicate = NSPredicate(format: "name = %@", userData.name)

        do {
            let userEntities = try context.fetch(fetchRequest)
            if let userEntity = userEntities.first {
                // Update the properties of the user entity
                userEntity.name = name
                userEntity.gender = gender
                userEntity.email = email
                userEntity.mobile = mobile
                

                // Save the changes to the managed object context
                try context.save()

                print("User data updated successfully")
            } else {
                print("User entity not found")
            }
        } catch {
            print("Failed to fetch user data or update: \(error)")
        }
    }

    }

