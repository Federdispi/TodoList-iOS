//
//  TodoList.swift
//  todolist
//
//  Created by Federico Di Spirito on 21/12/2022.
//

import Foundation

class TodoList {
    var category: String
    var sections: [Section]
    
    /*
     Constructor
     */
    init(category: String, sections: [Section]) {
        self.category = category
        self.sections = sections
    }
}
