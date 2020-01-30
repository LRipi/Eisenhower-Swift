//
//  TaskView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 30/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.random())
                .frame(width: 250.0, height: 300)
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
