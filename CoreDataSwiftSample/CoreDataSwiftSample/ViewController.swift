//
//  ViewController.swift
//  CoreDataSwiftSample
//
//  Created by SunilMaurya on 31/03/18.
//  Copyright © 2018 SunilMaurya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDict:[String : Any] = ["name":"Sunil", "email":"skm17081990@gmail.com", "userid":1, "address":"India"]
        let workDict:[String : Any] = ["workDate":NSDate(), "workName": "CoreData Learning"]
        CoreDataManager.sharedInstance.save(tableName: "User", dictionaryValues: userDict, arrayValues: [workDict])
        if let allUsers = CoreDataManager.sharedInstance.getAllObjects(tableName: "User") as? [User] {
            print(allUsers[0].name ?? "")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

