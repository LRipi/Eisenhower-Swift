//
//  TaskView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 30/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    let task: Tasks;
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.random())
                .frame(width: 200.0, height: 300)
            HStack {
                Text("\(task.id)")
                    .font(.title)
            }.position(x: 130, y: 280)
            VStack {
                Text("\(task.title)")
                    .font(.largeTitle)
                    .padding(.horizontal, 110.0)
                Divider()
                    .frame(width: 200.0, height: 1)
                Text("\(task.description)")
                    .font(.headline)
                    .padding(.horizontal, 110.0)
                
            }
            HStack {
                Text("\(task.urgence) / \(task.importance)")
                    .font(.subheadline)
            }.position(x: 280, y: 540)
        }
    }
}


struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: Tasks(id: 42, urgence: 2, importance: 3, title: "Faire un test", description: "Text à tester car il faut s'assurer que c'est pas de la giga bite.", deadline: Date()))
    }
}
