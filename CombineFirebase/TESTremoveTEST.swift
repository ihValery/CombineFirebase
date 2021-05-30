////
////  TESTremoveTEST.swift
////  CombineFirebase
////
////  Created by Валерий Игнатьев on 30.05.21.
////
//
//import SwiftUI
//
//struct TESTremoveTEST: View {
//    @ObservedObject private var signUpViewModel = SignUpViewModel()
//    
//    var body: some View {
//        Form {
//            Section() {
//                TextField("Username", text: $signUpViewModel.username)
//                    .autocapitalization(.none)
//            }
//            Section() {
//                Button(action: {}) {
//                    Text(self.signUpViewModel.isValidPassword ? "Зарегистрироваться" : "Заполните все поля")
//                }
//                .disabled(!self.userViewModel.isValidPassword)
//            }
//        }
//    }
//}
//
//struct TESTremoveTEST_Previews: PreviewProvider {
//    static var previews: some View {
//        TESTremoveTEST()
//    }
//}
