//
//  MatrixView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 23/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI

struct MatrixView: View {
    init(user: User) {
        self.user = user;
        var tmp = try? self.user.tasksRequester.fetchTasksNumber(parameters: [
            "importance": "false",
            "urgence": "true"
        ])
        if (tmp != nil) {
            self.firstBlock = tmp!["number"] as! Int
        }
        tmp = try? user.tasksRequester.fetchTasksNumber(parameters: [
            "importance": "true",
            "urgence": "true"
        ])
        if (tmp != nil) {
            self.secondBlock = tmp!["number"] as! Int
        }
        tmp = try? user.tasksRequester.fetchTasksNumber(parameters: [
            "importance": "false",
            "urgence": "false"
        ])
        if (tmp != nil) {
            self.thirdBlock = tmp!["number"] as! Int
        }
        tmp = try? user.tasksRequester.fetchTasksNumber(parameters: [
            "importance": "true",
            "urgence": "false"
        ])
        if (tmp != nil) {
            self.fourthBlock = tmp!["number"] as! Int
        }
        self.totalTasks = firstBlock + secondBlock + thirdBlock + fourthBlock
    }
    
    var user: User
    var totalTasks: Int = 0;
    var totalTasksHistory: Int = 0
    var firstBlock: Int = 0;
    var secondBlock: Int = 0;
    var thirdBlock: Int = 0;
    var fourthBlock: Int = 0;
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Total active tasks: ")
                        .font(.headline)
                        .bold()
                    Text("\(totalTasks)")
                        .font(.headline)
                        .bold()
                }
                HStack {
                    ZStack {
                        NavigationLink(destination: ListTaskView()) {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.purple)
                                .frame(width: 200.0, height: 220)
                        }.navigationBarTitle(Text("Matrix dashboard"))
                        VStack {
                            Text("Urgent")
                                .font(.title)
                            Text("Not important")
                                .font(.title)
                            Divider()
                            Text("\(firstBlock)")
                                .font(.largeTitle)
                        }
                    }
                    ZStack {
                        NavigationLink(destination: ListTaskView()) {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.green)
                                .frame(width: 200.0, height: 220)
                        }.navigationBarTitle(Text("Matrix dashboard"))
                        VStack {
                            Text("Urgent")
                                .font(.title)
                            Text("Important")
                                .font(.title)
                            Divider()
                            Text("\(secondBlock)")
                                .font(.largeTitle)
                        }
                    }
                }
                HStack {
                    ZStack {
                        NavigationLink(destination: ListTaskView()) {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.blue)
                                .frame(width: 200.0, height: 220)
                        }.navigationBarTitle(Text("Matrix dashboard"))
                        VStack {
                            Text("Not urgent")
                                .font(.title)
                            Text("Not important")
                                .font(.title)
                            Divider()
                            Text("\(thirdBlock)")
                                .font(.largeTitle)
                        }
                    }
                    ZStack {
                        NavigationLink(destination: ListTaskView()) {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.pink)
                                .frame(width: 200.0, height: 220)
                        }.navigationBarTitle(Text("Matrix dashboard"))
                        VStack {
                            Text("Not urgent")
                                .font(.title)
                            Text("Important")
                                .font(.title)
                            Divider()
                            Text("\(fourthBlock)")
                                .font(.largeTitle)
                        }
                    }
                }
                HStack {
                    Text("Number of tasks done: ")
                        .font(.headline)
                        .bold()
                    Text("6")
                        .font(.headline)
                        .bold()
                }
                HStack {
                    NavigationLink(destination: AddTaskView(user: user)) {
                        Text("Create new task")
                            .font(.body)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(40)
                            .foregroundColor(.white)
                    }.padding().navigationBarTitle(Text("Matrix Dashboard"))
                }
            }
        }
    }
}

#if DEBUG
struct MatrixView_Previews: PreviewProvider {
    static var userTest = User(email: "leo77500@gmail.com", name: "leo", token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc0FkbWluIjpmYWxzZSwidXNlcklkIjoxLCJpYXQiOjE1ODAyODg0MzcsImV4cCI6MTU4MDM3NDgzN30.sj3uoEWSPshM6RL9-OaT5yk702n50K6Aj6UMtfFCKnE")
    static var previews: some View {
        MatrixView(user: userTest)
    }
}
#endif
