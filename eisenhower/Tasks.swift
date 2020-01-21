//
//  Tasks.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 21/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import Foundation

class Tasks {
    var id: Int;
    var urgent: Int;
    var important: Int;
    var title: String;
    var description: String;
    var deadline: Date;
    
    init(id: Int, urgent: Int, important: Int, title: String, description: String, deadline: Date) {
        self.id = id;
        self.urgent = urgent;
        self.important = important;
        self.title = title;
        self.description = description;
        self.deadline = deadline;
    }
}
