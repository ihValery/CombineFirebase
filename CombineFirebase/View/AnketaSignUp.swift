//
//  AnketaSignUp.swift
//  SwiftUI_Firebase
//
//  Created by Валерий Игнатьев on 28.05.21.
//

import SwiftUI

struct AnketaSignUp: View {
    @ObservedObject private var signViewModel = SignViewModel.shared
    @State private var showPassword = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Image(systemName: "person.fill").padding(.leading, 3).padding(.trailing, 2)
                
                ZStack(alignment: .leading) {
                    if signViewModel.username.isEmpty { Text("Введите имя").opacity(0.7) }
                    TextField("", text: $signViewModel.username)
                }
            }
            Line()
            
            HStack {
                Image(systemName: "envelope.fill")
                
                ZStack(alignment: .leading) {
                    if signViewModel.email.isEmpty { Text("Укажите почту").opacity(0.7) }
                    TextField("", text: $signViewModel.email)
                }
            }
            Line()
            
            HStack {
                Image(systemName: "lock.fill").padding(.leading, 3).padding(.trailing, 2)
                
                ZStack(alignment: .trailing) {
                    if showPassword {
                        ZStack {
                            TextField("", text: $signViewModel.password)
                        }
                    } else {
                        ZStack(alignment: .leading) {
                            if signViewModel.password.isEmpty { Text("Придумайте пароль").opacity(0.7) }
                            SecureField("", text: $signViewModel.password)
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
                    if signViewModel.passwordAgain.isEmpty { Text("Повторите пароль").opacity(0.7) }
                    SecureField("", text: $signViewModel.passwordAgain)
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
