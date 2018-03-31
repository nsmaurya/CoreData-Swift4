//
//  User+CoreDataProperties.swift
//  CoreDataSwiftSample
//
//  Created by SunilMaurya on 31/03/18.
//  Copyright © 2018 SunilMaurya. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var userid: Int64
    @NSManaged public var address: String?
    @NSManaged public var workDetails: NSSet?

}

// MARK: Generated accessors for workDetails
extension User {

    @objc(addWorkDetailsObject:)
    @NSManaged public func addToWorkDetails(_ value: WorkDetails)

    @objc(removeWorkDetailsObject:)
    @NSManaged public func removeFromWorkDetails(_ value: WorkDetails)

    @objc(addWorkDetails:)
    @NSManaged public func addToWorkDetails(_ values: NSSet)

    @objc(removeWorkDetails:)
    @NSManaged public func removeFromWorkDetails(_ values: NSSet)

}
