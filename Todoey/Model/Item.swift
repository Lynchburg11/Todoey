//
//  Item.swift
//  Todoey
//
//  Created by Nils Nöhren on 07.01.18.
//  Copyright © 2018 Nils Nöhren. All rights reserved.
//

import Foundation
import RealmSwift


class item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date? 
    var parentCategory = LinkingObjects(fromType:  Category.self , property: "items")
}
