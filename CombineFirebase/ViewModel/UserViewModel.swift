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
    @Published var isValid = false
    
    @Published var messageError = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private static let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
    private static let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    
    private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
        $username
            //Оператор debounce позволяет нам сообщить системе, что мы хотим дождаться паузы в доставке событий,
            //например, когда пользователь перестает печатать.
            .debounce(for: 0.8, scheduler: RunLoop.main)
            //Oператор removeDuplicates будет публиковать события, только если они отличаются от любых предыдущих событий.
            .removeDuplicates()
            .map { $0.count >= 3 }
            //выполняет стирание некоторого ТИПА, оно гарантирует, что мы не получим некоторые сумасшедшие вложенные ТИПЫ возврата
            //и сможем их встроить в любую цепочку.
            .eraseToAnyPublisher()
    }
    
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { Self.emailPredicate.evaluate(with: $0) }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
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
    
    enum PasswordCheck {
        case notEmpty
        case notStrong
        case notMatch
        case valid
    }
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
        Publishers.CombineLatest3(isPasswordEmptyPublisher, isPasswordStrongPublisher, arePasswordEqualPublisher)
            .map {
                if $0 { return .notEmpty }
                if !$1 { return .notStrong }
                if !$2 { return .notMatch }
                return .valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isValidPublisher: AnyPublisher<Bool , Never> {
        Publishers.CombineLatest3(isUsernameValidPublisher, isEmailValidPublisher, isPasswordValidPublisher)
            .map { $0 && $1 && $2 == .valid }
            .eraseToAnyPublisher()
    }
    
    private init() {
        isUsernameValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map { $0 ? "" : "Минимальная длина Имени 3 символа" }
            .assign(to: \.messageError, on: self)
            .store(in: &cancellableSet)
        
        isEmailValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map { $0 ? "" : "Емаил не корректный" }
            .assign(to: \.messageError, on: self)
            .store(in: &cancellableSet)
        
        isPasswordValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map {
                switch $0 {
                    case .notEmpty: return "Пароль не должен быть пустым"
                    case .notStrong: return "Пароль недостаточно надежен"
                    case .notMatch: return "Пароли не совпадают"
                    default: return ""
                }
            }
            .assign(to: \.messageError, on: self)
            .store(in: &cancellableSet)
        
        isValidPublisher
            .dropFirst()
            //Поскольку этот код взаимодействует с UI, он должен работать на main потоке
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
}
