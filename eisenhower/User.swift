//
//  User.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 15/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import Foundation

class User {
    var email: String;
    var name: String;
    var token: String;
    var userRequester: UserRequester;
    var tasksRequester: TasksRequester
    var tasks: [Tasks];
    
    init(email: String, name: String, token: String) {
        self.email = email;
        self.name = name;
        self.token = token;
        self.userRequester = UserRequester(token: self.token);
        self.tasksRequester = TasksRequester(token: self.token);
        for (value) in tasksRequester.fetchTasks() {
            print(value)
        }
    }
}
