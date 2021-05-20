//
//  ViewModel.swift
//  Regulation
//
//  Created by Ryota Karita on 2021/05/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelProtocol {
    typealias Input = (
        email: Driver<String>,
        password: Driver<String>
    )
    
    typealias Output = (
        validate: Driver<Bool>, ()
    )
    
    var input: ViewModelProtocol.Input { get }
    var output: ViewModelProtocol.Output { get }
}

final class ViewModel: ViewModelProtocol {
    var input: (email: Driver<String>, password: Driver<String>)
    var output: (validate: Driver<Bool>, ())
    
    init(input: ViewModelProtocol.Input) {
        self.input = input
        self.output = ViewModel.output(input: self.input)
    }
}

private extension ViewModel {
    static func output(input: ViewModelProtocol.Input) -> ViewModelProtocol.Output {
        let validate = Driver.combineLatest(input.email, input.password) { (email, password) -> Bool in
            Validator.isEmail(email) && Validator.isPassword(password)
        }
        return (
            validate: validate, ()
        )
    }
}
