//
//  ContentView.swift
//  CombineFirebase
//
//  Created by Валерий Игнатьев on 29.05.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var signViewModel = SignViewModel.shared
    
    @State private var signInSelected = false
    @State private var presentAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orangeGradientStart, .orangeGradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            BackgroundAnimation()
                .drawingGroup()
                .ignoresSafeArea()
            
            VStack {
                HStack(spacing: 1) {
                    SignSelectButton(text: "Вход")
                        .opacity(!signInSelected ? 1 : 0.4)
                        .onTapGesture {
                            signInSelected = false
                        }
                    
                    SignSelectButton(text: "Регистрация")
                        .opacity(signInSelected ? 1 : 0.4)
                        .onTapGesture {
                            signInSelected = true
                        }
                }
                
                GeometryReader { gr in
                    VStack {
                        BackgroundCard(height: 320)
                            .overlay(AnketaSignUp().padding())
                            .offset(y: gr.size.height / 4.5)
                            .offset(x: signInSelected ? 0 : gr.size.width + 50)
                        
                        Button(self.signViewModel.isValidSignUp ? "Зарегистрироваться" : "Заполните все поля") {
                            signUp()
                            print("--------Зарегистрироваться--------")
                        }
                        .buttonStyle(SignStyleButton(colorBG: .white,
                                                     colorText: signViewModel.isValidSignUp ? .orangeGradientEnd : .gray))
                        .offset(y: signInSelected ? 230 : gr.size.height + 50)
                        .disabled(!signViewModel.isValidSignUp)
                    }
                    
                    VStack {
                        BackgroundCard(height: 190)
                            .overlay(AnketaSignIn().padding().padding(.bottom, -20))
                            .offset(y: gr.size.height / 3.5)
                            .offset(x: !signInSelected ? 0 : -gr.size.width - 50)
                        
                        Button(signViewModel.isValidSignIn ? "Войти" : "Заполните все поля") {
                            signUp()
                            print("--------Войти--------")
                        }
                        .buttonStyle(SignStyleButton(colorBG: .white,
                                                     colorText: signViewModel.isValidSignIn ? .orangeGradientEnd : .gray))
                        .offset(y: !signInSelected ? 340 : gr.size.height + 150)
                        .disabled(!signViewModel.isValidSignIn)
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
