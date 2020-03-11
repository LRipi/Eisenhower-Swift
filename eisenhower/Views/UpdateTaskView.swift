//
//  UpdateTaskView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 11/03/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI

extension UpdateTaskView {
    init(user: User, task: Tasks) {
        self.user = user;
        self.task = task;
        self.title = task.title;
        self.description = task.description;
        self.important = Double(task.importance);
        self.urgent = Double(task.urgence);
        self.deadline = task.deadline;
    }
}

struct UpdateTaskView: View {
    var user: User;
    var task: Tasks;
    @State var title: String = "";
    @State var description: String = "";
    @State var important: Double = 1;
    @State var urgent: Double = 1;
    @State var deadline: Date = Date();
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Update the task"), content: {
                    TextField("Enter the task's title", text: $title)
                    TextField("Enter a task description", text: $description)
                    Slider(value: $important, in: 1...10, step: 1)
                    Slider(value: $urgent, in: 1...10, step: 1)
                    DatePicker(selection: $deadline, in: ...Date(), displayedComponents: .date) {
                        Text("Choose your deadline")
                    }
                })
            }
            HStack {
                Button(action: {
                    try! self.user.tasksRequester.updateTask(id: self.task.id, urgent: Int(self.urgent), important: Int(self.important), title: self.title, description: self.description, deadline: self.deadline)
                }, label: {
                    Text("Submit")
                        .font(.body)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                })
            }
        }
    }
}

struct UpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTaskView(user: User(email: "", name: "", token: ""), task: Tasks(id: 1, urgence: 1, importance: 1, title: "TEST", description: "TEST", deadline: Date()))
    }
}
