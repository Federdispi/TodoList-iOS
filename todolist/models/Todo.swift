//
//  Todo.swift
//  todolist
//
//  Created by Federico Di Spirito on 07/11/2022.
//

import Foundation

class Todo {
    var nom: String
    var desc: String
    var done: Bool = false
    var date: Date
    
    /*
     Constructor
     */
    init(nom: String, desc: String, date: Date) {
        self.nom = nom
        self.desc = desc
        self.date = date
    }
}
