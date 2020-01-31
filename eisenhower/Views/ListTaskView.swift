//
//  ListTaskView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 27/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI

struct ListTaskView: View {
    var tasks: [Tasks]
    var body: some View {
        NavigationView {
            List(tasks) { taskItem in
                TaskView(task: taskItem)
            }.navigationBarTitle("Task list")
        }
    };
}

#if DEBUG
struct ListTaskView_Previews: PreviewProvider {
    static var tmp1 = Tasks(id: 42, urgence: 2, importance: 3, title: "Faire un test", description: "Text à tester car il faut s'assurer que c'est pas de la giga bite.", deadline: Date())
    static var tmp2 = Tasks(id: 41, urgence: 2, importance: 3, title: "Faire un test", description: "Text à tester car il faut s'assurer que c'est pas de la giga bite.", deadline: Date())
    static var tmp3 = Tasks(id: 43, urgence: 2, importance: 3, title: "Faire un test", description: "Text à tester car il faut s'assurer que c'est pas de la giga bite.", deadline: Date())
    static let tasksList = [tmp1, tmp2, tmp3];
    static var previews: some View {
        ListTaskView(tasks: tasksList)
    }
}
#endif
