//
//  AnketaSignIn.swift
//  SwiftUI_Firebase
//
//  Created by Валерий Игнатьев on 28.05.21.
//

import SwiftUI

struct AnketaSignIn: View {
    @ObservedObject private var signUpViewModel = SignUpViewModel.shared
    
//    @State var email: String = ""
//    @State var password: String = ""
    @State private var showPassword = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Image(systemName: "envelope.fill")
                
                ZStack(alignment: .leading) {
                    if signUpViewModel.email.isEmpty { Text("Введите почту").opacity(0.7) }
                    TextField("", text: $signUpViewModel.email)
                }
            }
            Line()
            
            HStack {
                Image(systemName: "lock.fill").padding(.leading, 3).padding(.trailing, 2)
                
                ZStack(alignment: .trailing) {
                    if showPassword {
                        ZStack {
                            TextField("", text: $signUpViewModel.passwordSignIn)
                        }
                    } else {
                        ZStack(alignment: .leading) {
                            if signUpViewModel.passwordSignIn.isEmpty { Text("Введите пароль").opacity(0.7) }
                            SecureField("", text: $signUpViewModel.passwordSignIn)
                        }
                    }
                    Button(action: { self.showPassword.toggle()}) {
                        Image(systemName: "eye").opacity(showPassword ? 1 : 0.2)
                    }
                }
            }
            Line()
            
            HStack {
                Spacer()
                Button("Забыли пароль?") {
                    print("Забыл пароль?")
                }
                .font(.subheadline.bold()).opacity(0.2)
            }
            .padding(.top, -15)
        }
        .textFieldStyle(DefaultTextFieldStyle())
        .font(.title2)
        .foregroundColor(.orangeGradientEnd)
        .padding()
    }
}

struct FillSignIn_Previews: PreviewProvider {
    static var previews: some View {
        AnketaSignIn()
    }
}
