//
//  UserData+CoreDataProperties.swift
//  TaskCoreData
//
//  Created by SangeethaKalis on 30/04/24.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: String?
    @NSManaged public var mobile: String?
    @NSManaged public var name: String?

}

extension UserData : Identifiable {

}
