//
//  RegisterView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 22/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    var Requester: EisenhowerRequester = EisenhowerRequester()
    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Register"), content: {
                        TextField("Enter your email", text: $email)
                            .autocapitalization(.none)
                        TextField("Entre your username", text: $name)
                            .autocapitalization(.none)
                        TextField("Enter your password", text: $password)
                            .autocapitalization(.none)
                    })
                }
                HStack {
                    Button(action: {
                        guard let user = try? self.Requester.register(email: self.email, password: self.password, name: self.name) else { return };
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
                    NavigationLink(destination: LoginView()) {
                        Text("Se connecter")
                            .font(.body)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(40)
                            .foregroundColor(.white)
                    }.navigationBarTitle(Text("Inscription"))
                }
            }
        }
    }
}

#if DEBUG
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
#endif
