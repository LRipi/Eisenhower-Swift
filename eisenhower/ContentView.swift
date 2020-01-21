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
    var Requester: EisenhowerRequester = EisenhowerRequester()
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Connection"), content: {
                    TextField("Enter your email", text: $email)
                    TextField("Enter your password", text: $password)
                })
            }
            HStack {
                Button(action: {
                    guard let user = try? self.Requester.login(email: self.email, password: self.password) else { return };
                    for (key, value) in user {
                        print(key, value)
                    }
                }) {
                    Text("Se connecter")
                        .font(.body)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)

                }
                Button(action: {
                    guard let user = try? self.Requester.getUser(email: "leo77500@gmail.com", password: "leogossboo2") else { return };
                    for (key, value) in user {
                        print(key, value)
                    }
                }) {
                    Text("S'inscrire")
                        .font(.body)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                }
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
