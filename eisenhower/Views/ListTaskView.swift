//
//  ListTaskView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 27/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI

struct ListTaskView: View {
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
             HStack {
                Text("KEK")
             }
        }.frame(height: 500)
    }
}

struct ListTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ListTaskView()
    }
}
