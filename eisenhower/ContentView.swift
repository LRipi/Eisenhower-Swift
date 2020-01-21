//
//  ContentView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 14/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI
import PromiseKit

struct ContentView: View {
    var Requester: Request = Request()
    var body: some View {
        VStack {
            Form {
            Section(header: Text("Connection"), content: {
                    Text("Name")
                    Spacer()
                    Text("iPhone 11")
                })
            }
            
            Button(action: {
                guard let user = try? self.Requester.getUser(email: "leo77500@gmail.com", password: "leogossboo2") else { return };
                for (key, value) in user {
                    print(key, value)
                }
            }) {
                Text("Hello  World")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.purple, lineWidth: 5)
                    )
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
