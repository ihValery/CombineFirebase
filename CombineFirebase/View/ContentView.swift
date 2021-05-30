//
//  ContentView.swift
//  CombineFirebase
//
//  Created by Валерий Игнатьев on 29.05.21.
//

import SwiftUI

struct ContentView: View {
    @State private var signInSelected = true
    @State private var signUpSelected = false
    @State private var presentAlert = false
    @State private var isTap = false
    
    @ObservedObject private var signUpViewModel = SignUpViewModel.shared
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orangeGradientStart, .orangeGradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
//            BackgroundAnimation()
//                .drawingGroup()
//                .ignoresSafeArea()
            
            VStack {
                HStack(spacing: 1) {
                    SignSelectButton(text: "Вход")
                        .opacity(signUpSelected ? 1 : 0.4)
                        .onTapGesture {
                            signInSelected = false
                            signUpSelected = true
                        }
                    
                    SignSelectButton(text: "Регистрация")
                        .opacity(signInSelected ? 1 : 0.4)
                        .onTapGesture {
                            signInSelected = true
                            signUpSelected = false
                        }
                }
                
                GeometryReader { gr in
                    VStack {
                        BackgroundCard(height: 320)
                            .overlay(AnketaSignUp().padding())
                            .offset(y: gr.size.height / 4.5)
                            .offset(x: signInSelected ? 0 : gr.size.width + 50)
                        
                        Button(self.signUpViewModel.isValid ? "Зарегистрироваться" : "Заполните все поля") {
                            signUp()
                            print("--------Зарегистрироваться--------")
                        }
                        .buttonStyle(SignStyleButton(colorBG: .white, colorText: .orangeGradientEnd))
                        .offset(y: signInSelected ? 230 : gr.size.height + 50)
                        .disabled(!signUpViewModel.isValid)
                    }
                    
                    VStack {
                        BackgroundCard(height: 190)
                            .overlay(AnketaSignIn().padding().padding(.bottom, -20))
                            .offset(y: gr.size.height / 3.5)
                            .offset(x: signUpSelected ? 0 : -gr.size.width - 50)
                        
                        Button(signUpViewModel.isValidSignIn ? "Войти" : "Заполните все поля") {
                            signUp()
                            print("--------Войти--------")
                        }
                        .buttonStyle(SignStyleButton(colorBG: .white, colorText: .orangeGradientEnd))
                        .offset(y: signUpSelected ? 340 : gr.size.height + 150)
                        .disabled(!signUpViewModel.isValidSignIn)
                    }
                }
                .animation(.easeInOut)
            }
        }
        .sheet(isPresented: $presentAlert, content: {
            WelcomView()
        })
    }
    func signUp() {
        presentAlert = true
    }
}

struct WelcomView: View {
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            Text("Welcom! Greate to have you on board!")
                .font(.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
