//
//  LoginView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 14/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI
import PromiseKit

struct LoginView: View {
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
                    Text("Soumettre")
                        .font(.body)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)

                }
                Button(action: {
                    print("WIP Switch Register")
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
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
