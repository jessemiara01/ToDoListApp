//
//  Categories.swift
//  ToDoListApp
//
//  Created by Jesse Miara on 7/6/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import Foundation
import RealmSwift

class Categories: Object{
    @objc dynamic var categoryName : String = ""
    let itemsForCategory = List<ToDoItems>()
}
