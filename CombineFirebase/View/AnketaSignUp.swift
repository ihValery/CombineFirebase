//
//  AnketaSignUp.swift
//  SwiftUI_Firebase
//
//  Created by Валерий Игнатьев on 28.05.21.
//

import SwiftUI

struct AnketaSignUp: View {
    @ObservedObject private var userViewModel = UserViewModel.shared
    
//    @State var name: String = ""
//    @State var email: String = ""
//    @State var password: String = ""
//    @State var rePassword: String = ""
    
    @State private var showPassword = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Image(systemName: "person.fill").padding(.leading, 3).padding(.trailing, 2)
                
                ZStack(alignment: .leading) {
                    if userViewModel.username.isEmpty { Text("Введите имя").opacity(0.7) }
                    TextField("", text: $userViewModel.username)
                }
            }
            Line()
            
            HStack {
                Image(systemName: "envelope.fill")
                
                ZStack(alignment: .leading) {
                    if userViewModel.email.isEmpty { Text("Укажите почту").opacity(0.7) }
                    TextField("", text: $userViewModel.email)
                }
            }
            Line()
            
            HStack {
                Image(systemName: "lock.fill").padding(.leading, 3).padding(.trailing, 2)
                
                ZStack(alignment: .trailing) {
                    if showPassword {
                        ZStack {
                            TextField("", text: $userViewModel.password)
                        }
                    } else {
                        ZStack(alignment: .leading) {
                            if userViewModel.password.isEmpty { Text("Придумайте пароль").opacity(0.7) }
                            SecureField("", text: $userViewModel.password)
                        }
                    }
                    Button(action: { self.showPassword.toggle()}) {
                        Image(systemName: "eye").opacity(showPassword ? 1 : 0.2)
                    }
                }
            }
            Line()
            
            HStack {
                Image(systemName: "lock.fill").padding(.leading, 3).padding(.trailing, 2)
                
                ZStack (alignment: .leading) {
                    if userViewModel.passwordAgain.isEmpty { Text("Повторите пароль").opacity(0.7) }
                    SecureField("", text: $userViewModel.passwordAgain)
                }
            }
            Line()
        }
        .textFieldStyle(DefaultTextFieldStyle())
        .font(.title2)
        .foregroundColor(.orangeGradientEnd)
        .padding()
    }
}

struct CardForFill_Previews: PreviewProvider {
    static var previews: some View {
        AnketaSignUp()
    }
}
