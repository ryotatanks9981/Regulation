//
//  Validator.swift
//  Regulation
//
//  Created by Ryota Karita on 2021/05/20.
//

import Foundation

class Validator {
    static func isEmail(_ email: String) -> Bool {
        let pattern = "^[\\w\\.\\-_]+@[\\w\\.\\-_]+\\.[a-zA-Z]+$"
        let matches = validate(str: email, pattern: pattern)
        return matches.count > 0
    }
    
    static func isPassword(_ password: String) -> Bool {
        let pattern = "^(?=.*?[^\\w])(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\\d])[!-~]{6,20}$"
        let matches = validate(str: password, pattern: pattern)
        return matches.count > 0
    }
    
    private static func validate(str: String, pattern: String) -> [NSTextCheckingResult] {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        return regex.matches(in: str, range: NSRange(location: 0, length: str.count))
    }
}
