//
//  Section.swift
//  todolist
//
//  Created by Federico Di Spirito on 06/12/2022.
//

import Foundation

class Section {
    var title: String
    var todos: [Todo]
    
    /*
     Constructor
     */
    init(title: String, todos: [Todo]) {
        self.title = title
        self.todos = todos
    }
}
