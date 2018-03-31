//
//  WorkDetails+CoreDataProperties.swift
//  CoreDataSwiftSample
//
//  Created by SunilMaurya on 31/03/18.
//  Copyright © 2018 SunilMaurya. All rights reserved.
//
//

import Foundation
import CoreData


extension WorkDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkDetails> {
        return NSFetchRequest<WorkDetails>(entityName: "WorkDetails")
    }

    @NSManaged public var workName: String?
    @NSManaged public var workDate: NSDate?

}
