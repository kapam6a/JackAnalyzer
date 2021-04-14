//
//  Tokenizer.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 14.04.2021.
//

import Foundation

enum Token {
    case keyword
    case symbol
    case intConst
    case stringConst
}

enum Keyword {
    case `class`
    case method
    case function
    case constructor
    case int
    case boolean
    case char
    case void
    case `var`
    case `static`
    case field
    case `let`
    case `do`
    case `if`
    case `else`
    case `while`
    case `return`
    case `true`
    case `false`
    case null
    case this
}

final class Tokenizer {
    
    private let code: String
    
    init(_ code: String) {
        self.code = code
    }
    
    func hasMoreTokens() -> Bool {
        true
    }
    
    func advance() {
        
    }
    
    func tokenType() -> Token {
        .keyword
    }
    
    func keyword() -> Keyword {
        .boolean
    }
    
    func symbol() -> String {
        ""
    }
    
    func identifier() -> String {
        ""
    }
    
    func intVal() -> Int {
        0
    }
    
    func stringVal() -> String {
        ""
    }
}
