//
//  ListTaskView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 27/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI

struct ListTaskView: View {
    @State var tasks: [Tasks];
    @State var editMode: EditMode = .inactive;
    @State var selectedTasks = Set<String>();
    var user: User
    var body: some View {
        List {
            ForEach(tasks) { taskItem in
                NavigationLink(destination: UpdateTaskView(user: self.user, task: taskItem)) {
                    TaskView(task: taskItem)
                }
            }
            .onDelete(perform: deleteItem)
        }
        .navigationBarTitle("Task list", displayMode: .inline)
        .navigationBarItems(trailing:
            NavigationLink(destination: AddTaskView(user: self.user)) {
                Image(systemName: "plus")
            }
        )
    };
    
    private func deleteItem(at offset: IndexSet) -> Void{
        user.tasksRequester.deleteTask(id: tasks[offset.first!].id);
        tasks.remove(atOffsets: offset)
    }
}

#if DEBUG
struct ListTaskView_Previews: PreviewProvider {
    static var tmp1 = Tasks(id: 7, urgence: 2, importance: 3, title: "Faire un test", description: "Text à tester car il faut s'assurer que c'est pas de la giga bite.", deadline: Date())
    static var tmp2 = Tasks(id: 8, urgence: 2, importance: 3, title: "Faire un test", description: "Text à tester car il faut s'assurer que c'est pas de la giga bite.", deadline: Date())
    static var tmp3 = Tasks(id: 9, urgence: 2, importance: 3, title: "Faire un test", description: "Text à tester car il faut s'assurer que c'est pas de la giga bite.", deadline: Date())
    static let tasksList: [Tasks] = [tmp1, tmp2, tmp3];
    static var userTest = User(email: "leo.riberon-piatyszek@epitech.eu", name: "leo", token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc0FkbWluIjpmYWxzZSwidXNlcklkIjoxLCJpYXQiOjE1ODM4NDQ3MDUsImV4cCI6MTU4MzkzMTEwNX0.V0tiFRODGUVwrp1OtjyIiArkieEP12E7XrRi9NUE92o")
    static var previews: some View {
        ListTaskView(tasks: tasksList, user: userTest)
    }
}
#endif
