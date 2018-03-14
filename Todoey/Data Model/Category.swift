//
//  Category.swift
//  Todoey
//
//  Created by Amandeep Singh on 27/02/18.
//  Copyright © 2018 Amandeep Singh. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    @objc dynamic var color = ""
    let items = List<Item>()
    
}
