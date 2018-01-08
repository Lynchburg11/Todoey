//
//  Category.swift
//  Todoey
//
//  Created by Nils Nöhren on 07.01.18.
//  Copyright © 2018 Nils Nöhren. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    
    @objc dynamic var name: String = ""
    let items = List<item>()
    
    
}
