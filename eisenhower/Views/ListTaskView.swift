//
//  ListTaskView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 27/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI

extension ListTaskView {
    init() {
        self.tmp1 = Tasks(id: 42, urgence: 2, importance: 3, title: "Faire un test", description: "Text à tester car il faut s'assurer que c'est pas de la giga bite.", deadline: Date())
        self.tmp2 = Tasks(id: 41, urgence: 2, importance: 3, title: "Faire un test", description: "Text à tester car il faut s'assurer que c'est pas de la giga bite.", deadline: Date())
        self.tasks = [tmp1, tmp2];
    }
}

struct ListTaskView: View {
    var tmp1: Tasks
    var tmp2: Tasks
    var tasks: [Tasks]
    var body: some View {
        NavigationView {
            List(tasks) { taskItem in
                TaskView(task: taskItem)
            }.navigationBarTitle("Task list")
        }
    };
}

struct ListTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ListTaskView()
    }
}
