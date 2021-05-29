//
//  UserViewModel.swift
//  CombineFirebase
//
//  Created by Валерий Игнатьев on 29.05.21.
//

import Combine
import Foundation

class UserViewModel: ObservableObject {
    static let shared = UserViewModel()
    
    //input
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    
    //output
    @Published var isValidEmail = false
    @Published var isValidPassword = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private static let passwordPredicate = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
    
    private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
        $username
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 3 }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            //выполняет стирание некоторого ТИПА, оно гарантирует, что мы не получим некоторые сумасшедшие вложенные ТИПЫ возврата
            //и сможем их встроить в любую цепочку.
            .eraseToAnyPublisher()
    }
    
    private var isPasswordStrongPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { Self.passwordPredicate.evaluate(with: $0) }
            .eraseToAnyPublisher()
    }
    
    private var arePasswordEqualPublisher: AnyPublisher<Bool, Never> {
        //содержат ли два отдельных свойства одинаковые строки String, мы используем оператор CombineLatest
        Publishers.CombineLatest($password, $passwordAgain)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { $0 == $1 }
            .eraseToAnyPublisher()
    }
    
    private init() {
        $username
            //Оператор debounce позволяет нам сообщить системе, что мы хотим дождаться паузы в доставке событий,
            //например, когда пользователь перестает печатать.
            .debounce(for: 0.8, scheduler: RunLoop.main)
            //Oператор removeDuplicates будет публиковать события, только если они отличаются от любых предыдущих событий.
            .removeDuplicates()
            .map { $0.count >= 3 }
            .assign(to: \.isValidPassword, on: self)
            .store(in: &cancellableSet)
    }
}
