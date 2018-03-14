//
//  Item.swift
//  Todoey
//
//  Created by Amandeep Singh on 27/02/18.
//  Copyright © 2018 Amandeep Singh. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
    
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
