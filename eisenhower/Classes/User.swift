//
//  User.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 15/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import Foundation

class User {
    let email: String;
    let name: String;
    let token: String;
    let userRequester: UserRequester;
    let tasksRequester: TasksRequester;
    var tasks: [Tasks];
    var tasksHistory: [Tasks];
    
    init(email: String, name: String, token: String) {
        self.email = email;
        self.name = name;
        self.token = token;
        self.userRequester = UserRequester(token: self.token);
        self.tasksRequester = TasksRequester(token: self.token);
        self.tasks = []
        self.tasksHistory = []
        self.initTasks()
        self.initTasksHistory()
    }
    
    func initTasks() {
        let fetchedTasks = try? tasksRequester.fetchTasks()
        if (fetchedTasks != nil) {
            let tasksArray = fetchedTasks?["tasks"] as! [[String: Any]]
            for (value) in tasksArray {
                let id: Int = value["id"] as! Int;
                let description: String = value["description"] as! String;
                let title: String = value["title"] as! String;
                let importance: Int = value["importance"] as! Int;
                let urgence: Int = value["urgence"] as! Int;
                let deadlineIso = value["deadline"] as! String
                let deadline = Date.dateFromISOString(string: deadlineIso)
                self.tasks.append(Tasks(id: id, urgence: urgence, importance: importance, title: title, description: description, deadline: deadline!))
            }
        }
    }
    
    func initTasksHistory() {
        let fetchedTasks = try? tasksRequester.fetchRemovedTasks()
        if (fetchedTasks != nil) {
            let tasksArray = fetchedTasks?["tasks"] as! [[String: Any]]
            for (value) in tasksArray {
                let id: Int = value["id"] as! Int;
                let description: String = value["description"] as! String;
                let title: String = value["title"] as! String;
                let importance: Int = value["importance"] as! Int;
                let urgence: Int = value["urgence"] as! Int;
                let deadlineIso = value["deadline"] as! String
                let deadline = Date.dateFromISOString(string: deadlineIso)
                self.tasksHistory.append(Tasks(id: id, urgence: urgence, importance: importance, title: title, description: description, deadline: deadline!))
            }
        }
    }
}
