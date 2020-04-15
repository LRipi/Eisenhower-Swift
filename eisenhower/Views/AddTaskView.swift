//
//  AddTaskView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 23/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI

struct AddTaskView: View {
    var user: User;
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
                    Slider(value: $important, in: 1...10, step: 1.0)
                    Slider(value: $urgent, in: 1...10, step: 1.0)
                    DatePicker(selection: $deadline, in: Date()..., displayedComponents: .date) {
                        Text("Choose your deadline")
                    }
                })
            }
            HStack {
                NavigationLink(destination: MatrixView(user: self.user)) {
                Button(action: {
                    try! self.user.tasksRequester.createTask(urgence: Int(self.urgent), importance: Int(self.important), title: self.title, description: self.description, deadline: self.deadline)
                }, label: {
                    Text("Submit")
                        .font(.body)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                })
                }.navigationBarTitle("Navigation")
            }
        }
    }
}

#if DEBUG
struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(user: User(email: "", name: "", token: ""))
    }
}
#endif
