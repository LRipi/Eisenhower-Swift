//
//  LoginView.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 14/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import SwiftUI
import PromiseKit
import NavigationStack

struct LoginView: View {
    func logUser() -> User {
        guard let response = try? self.Requester.login(email: self.email, password: self.password) else { return User(email: "", name: "", token: "")}
        let name = response["user"]?["name"] as! String
        let login = response["user"]?["login"] as! String
        let token = response["user"]?["token"] as! String
        let user = User(email: login, name: name, token: token)
        return user
    }
    
    var Requester: EisenhowerRequester = EisenhowerRequester()
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStackView {
            VStack {
                Form {
                    Section(header: Text("Connection").bold().foregroundColor(Color.black).font(.system(size: 40)), content: {
                        TextField("Enter your email", text: $email)
                            .autocapitalization(.none)
                        SecureField("Enter your password", text: $password)
                    })
                }
                HStack {
                    PushView(destination: MatrixView(user: self.logUser())) {
                        Text("Soumettre")
                            .font(.body)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(40)
                            .foregroundColor(.white)
                    }.navigationBarTitle(Text("Connection"))
                    PushView(destination: RegisterView()) {
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
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
