//
//  AnketaSignUp.swift
//  SwiftUI_Firebase
//
//  Created by Валерий Игнатьев on 28.05.21.
//

import SwiftUI

struct AnketaSignUp: View {
    @ObservedObject private var signUpViewModel = SignUpViewModel.shared
    @State private var showPassword = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Image(systemName: "person.fill").padding(.leading, 3).padding(.trailing, 2)
                
                ZStack(alignment: .leading) {
                    if signUpViewModel.username.isEmpty { Text("Введите имя").opacity(0.7) }
                    TextField("", text: $signUpViewModel.username)
                }
            }
            Line()
            
            HStack {
                Image(systemName: "envelope.fill")
                
                ZStack(alignment: .leading) {
                    if signUpViewModel.email.isEmpty { Text("Укажите почту").opacity(0.7) }
                    TextField("", text: $signUpViewModel.email)
                }
            }
            Line()
            
            HStack {
                Image(systemName: "lock.fill").padding(.leading, 3).padding(.trailing, 2)
                
                ZStack(alignment: .trailing) {
                    if showPassword {
                        ZStack {
                            TextField("", text: $signUpViewModel.password)
                        }
                    } else {
                        ZStack(alignment: .leading) {
                            if signUpViewModel.password.isEmpty { Text("Придумайте пароль").opacity(0.7) }
                            SecureField("", text: $signUpViewModel.password)
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
                    if signUpViewModel.passwordAgain.isEmpty { Text("Повторите пароль").opacity(0.7) }
                    SecureField("", text: $signUpViewModel.passwordAgain)
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
