//
//  Tasks.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 21/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import Foundation

class Tasks: Identifiable {
    var id: Int;
    var urgence: Int;
    var importance: Int;
    var title: String;
    var description: String;
    var deadline: Date;
    
    init(id: Int, urgence: Int, importance: Int, title: String, description: String, deadline: Date) {
        self.id = id;
        self.urgence = urgence;
        self.importance = importance;
        self.title = title;
        self.description = description;
        self.deadline = deadline;
    }
}
