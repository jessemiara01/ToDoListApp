//
//  toDoItems.swift
//  ToDoListApp
//
//  Created by Jesse Miara on 7/6/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoItems: Object{
    @objc dynamic var itemsToDo : String = ""
    @objc dynamic var itemIsChecked : Bool = false
    
    var parentCategory = LinkingObjects(fromType: Categories.self, property: "itemsForCategory")
}
