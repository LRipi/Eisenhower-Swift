//
//  RegisterView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 22/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI
import NavigationStack

struct RegisterView: View {
    var Requester: EisenhowerRequester = EisenhowerRequester()
    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    @EnvironmentObject private var navigationStack: NavigationStack
    var body: some View {
        NavigationStackView {
            VStack {
                Form {
                    Section(header: Text("Register").bold().foregroundColor(Color.black).font(.system(size: 40)), content: {
                        TextField("Enter your email", text: $email)
                            .autocapitalization(.none)
                        TextField("Entre your username", text: $name)
                            .autocapitalization(.none)
                        SecureField("Enter your password", text: $password)
                    })
                }
                HStack {
                    Button(action: {
                        guard let user = try? self.Requester.register(email: self.email, password: self.password, name: self.name) else { return };
                        for (key, value) in user {
                            print(key, value)
                        }
                        self.navigationStack.pop()
                    }) {
                        Text("Soumettre")
                            .font(.body)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(40)
                            .foregroundColor(.white)
                        
                    }
                    Button(action: {
                        self.navigationStack.pop()
                    }) {
                        Text("Connection")
                            .font(.body)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(40)
                            .foregroundColor(.white)
                        
                    }
                }
            }.navigationBarTitle(Text("Inscription"))
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
