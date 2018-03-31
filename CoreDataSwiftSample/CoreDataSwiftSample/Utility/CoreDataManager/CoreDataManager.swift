
//
//  CoreDataManager.swift
//  CoreDataSwiftSample
//
//  Created by SunilMaurya on 31/03/18.
//  Copyright © 2018 SunilMaurya. All rights reserved.
//

import Foundation
import CoreData
import UIKit

private let _sharedInstance = CoreDataManager()
class CoreDataManager {
    class var sharedInstance: CoreDataManager {
        return _sharedInstance
    }
    
    private func getManagedObjectContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    private func getEntityDescription(tableName:String) -> NSEntityDescription? {
        guard let managedContext = getManagedObjectContext() else {
            return nil
        }
        guard let entityDescription = NSEntityDescription.entity(forEntityName: tableName, in: managedContext) else {
            return nil
        }
        return entityDescription
    }
    
    /*
     * This method is used for saving data in given table
     * tableName, for table on which value get saved
     * dictionaryValues, for mapping key-value as table attribute-value
     * arrayValues, for relational values, mapping key-value as table attribute-value
     */
    @discardableResult func save(tableName:String, dictionaryValues:[String:Any]? = nil, arrayValues:[Any]? = nil) -> Bool {
        
        guard let managedContext = getManagedObjectContext(), let entityDescription = getEntityDescription(tableName: tableName) else {
            return false
        }
        
        //for user table only
        if tableName == "User" {
            let user = User.init(entity: entityDescription, insertInto: managedContext)
            //if dictionary keys name same as User attribute name then
            if let dictValues = dictionaryValues {
                for (key,value) in dictValues {
                    user.setValue(value, forKey: key)
                }
            }
            //setting relationship
            if let relationValueArray = arrayValues, let workEntityDescription = getEntityDescription(tableName: "WorkDetails") {
                for value in relationValueArray {
                    if let workDict = value as? Dictionary<String,Any>  {
                        let workDetail = WorkDetails.init(entity: workEntityDescription, insertInto: managedContext)
                        //if dictionary keys name same as WorkDetails attribute name then
                        for (key,value) in workDict {
                            workDetail.setValue(value, forKey: key)
                        }
                        user.workDetails?.adding(workDetail)
                    }
                }
            }
        }
        
        //saving user in core data
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
        return true
    }
    
    /*
     * This method is used for getting all records from table
     * tableName, table from which data gets fetched
     * predicate, any specific condition, same as WHERE clause in DBMS
     * sorting, takes an array of sorting option on data, same as ORDER BY clause in DBMS
     */
    func getAllObjects(tableName:String, predicate:NSPredicate? = nil, sorting:[NSSortDescriptor]? = nil) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: tableName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sorting
        fetchRequest.returnsObjectsAsFaults = false
        guard let managedContext = getManagedObjectContext() else {
            return nil
        }
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as? [NSManagedObject]
        } catch {
            print("Failed to getAllObjects...")
            return nil
        }
    }
    
    /*
     * This method is used for getting single record from table
     * tableName, table from which data gets fetched
     * predicate, any specific condition, same as WHERE clause in DBMS
     */
    func getSingleObject(tableName:String, predicate:NSPredicate? = nil) -> NSManagedObject? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: tableName)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        fetchRequest.returnsObjectsAsFaults = false
        guard let managedContext = getManagedObjectContext() else {
            return nil
        }
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result[0] as? NSManagedObject
        } catch {
            print("Failed to getAllObjects...")
            return nil
        }
    }
    
    /*
     * This method is used for delete single record from table
     * tableName, table from which data gets fetched
     * object, object which is being deleted
     */
    func deleteSingleObject(object:NSManagedObject) -> Bool {
        guard let managedContext = getManagedObjectContext() else {
            return false
        }
        managedContext.delete(object)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
        return true
    }
    
    /*
     * This method is used for delete all records from table
     * tableName, table from which data gets fetched
     */
    func deleteAllObjects(tableName:String) -> Bool {
        guard let managedContext = getManagedObjectContext() else {
            return false
        }
        if let allData = getAllObjects(tableName: tableName) {
            for data in allData {
                managedContext.delete(data)
            }
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                return false
            }
            return true
        }
        return false
    }
}
