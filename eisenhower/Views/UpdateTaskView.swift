//
//  UpdateTaskView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 11/03/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI

struct UpdateTaskView: View {
    var user: User;
    @State var id: Int = 1;
    @State var title: String = "";
    @State var description: String = "";
    @State var important: Double = 1;
    @State var urgent: Double = 1;
    @State var deadline: Date = Date();
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Create a task"), content: {
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
                    try! self.user.tasksRequester.updateTask(id: self.id, urgent: Int(self.urgent), important: Int(self.important), title: self.title, description: self.description, deadline: self.deadline)
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
        UpdateTaskView(user: User(email: "", name: "", token: ""))
    }
}
