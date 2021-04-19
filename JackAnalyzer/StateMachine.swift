//
//  StateMachine.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 18.04.2021.
//

import Foundation

open class State {
    
    let symbols: [String: Symbol] = [
        "{": .openingCurlyBracket,
        "}": .closingCurlyBracket,
        "(": .openingRoundBracket,
        ")": .closingRoundBracket,
        "]": .openingSquareBracket,
        "[": .closingSquareBracket,
        ".": .dot,
        ",": .comma,
        ";": .simecolons,
        "+": .plusSign,
        "-": .minusSign,
        "*": .multiplicationSign,
        "/": .divisionSign,
        "&": .ampersand,
        "|": .verticalBar,
        "<": .less,
        ">": .more,
        "=": .equal,
        "~": .tilde
    ]
    
    let keywords: [String: Keyword] = [
        "class": .class,
        "constructor": .constructor,
        "function": .function,
        "method": .method,
        "field": .field,
        "static": .static,
        "var": .var,
        "int": .int,
        "char": .char,
        "boolean": .boolean,
        "void": .void,
        "true": .true,
        "false": .false,
        "null": .null,
        "this": .this,
        "let": .let,
        "do": .do,
        "if": .if,
        "else": .else,
        "while": .while,
        "return": .return,
    ]
    
    weak var stateMachine: StateMachine?
    
    func eat(_ char: String) throws {}
    func endOfString() throws {}
}

final class Initial: State {
    
    override func eat(_ char: String) throws {
        if Character(char).isNumber {
            let newState = IntegerLiteralState(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else if char == "\"" {
            let newState = StringLiteralState(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else if char == "/" {
            let newState = CommentOrSymbol(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else if symbols.keys.contains(char) {
            let newState = SymbolState(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else if ![" ", "\n", "\t"].contains(char) {
            let newState = IdentifierOrKeywordState(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        }
    }
}

final class IdentifierOrKeywordState: State {
    
    private var lexeme: String = ""
    
    init(_ char: String) {
        lexeme.append(char)
    }
    
    override func eat(_ char: String) throws {
        if [" ", "\n", "\t"].contains(char) || symbols.keys.contains(char) {
            try addToken()
        } else {
            lexeme.append(char)
        }
    }
    
    override func endOfString() throws {
        try addToken()
    }
    
    func addToken() throws {
        if keywords.keys.contains(lexeme) {
            try addKeywordToken()
        } else {
            try addIdenfifierToken()
        }
    }
    
    func addIdenfifierToken() throws {
        let token = TokenV2(type: .identifier(lexeme),
                            lexeme: lexeme)
        try stateMachine?.tokenizer?.add(token)
    }
    
    func addKeywordToken() throws {
        let token = TokenV2(type: .keyword(keywords[lexeme]!),
                            lexeme: lexeme)
        try stateMachine?.tokenizer?.add(token)
    }
}

final class IntegerLiteralState: State {
    
    enum DigitError: Error {
        case notSupportedSymbol
    }
    
    private var lexeme: String = ""
    
    init(_ char: String) {
        lexeme.append(char)
    }
    
    override func eat(_ char: String) throws {
        if [" ", "\n", "\t"].contains(char) || symbols.keys.contains(char) {
            try addToken()
        } else if Character(char).isNumber {
            lexeme.append(char)
        } else {
            throw DigitError.notSupportedSymbol
        }
    }
    
    override func endOfString() throws {
        try addToken()
    }
    
    func addToken() throws {
        let token = TokenV2(type: .intConst(Int(lexeme)!),
                            lexeme: lexeme)
        try stateMachine?.tokenizer?.add(token)
    }
}

final class SymbolState: State {
    
    private let lexeme: String
    
    init(_ char: String) {
        self.lexeme = char
    }
    
    override func eat(_ char: String) throws {
        try addToken()
    }
    
    override func endOfString() throws {
        try addToken()
    }
    
    func addToken() throws {
        let token = TokenV2(type: .symbol(symbols[lexeme]!),
                            lexeme: lexeme)
        try stateMachine?.tokenizer?.add(token)
    }
}

final class StringLiteralState: State {
    
    enum StringLiteralStateError: Error {
        case stringMustEndWithQuotes
    }
    
    private var lexeme: String = ""
    
    init(_ char: String) {
        lexeme.append(char)
    }
    
    override func eat(_ char: String) throws {
        if lexeme.hasSuffix("\"") && lexeme.hasPrefix("\"") && lexeme.length > 1 {
            try addToken()
        } else {
            lexeme.append(char)
        }
    }
    
    override func endOfString() throws {
        if lexeme.hasSuffix("\"") && lexeme.hasPrefix("\"") && lexeme.length > 1 {
            try addToken()
        } else {
            throw StringLiteralStateError.stringMustEndWithQuotes
        }
    }
    
    func addToken() throws {
        let string = String(lexeme.dropFirst().dropLast())
        let token = TokenV2(type: .stringConst(string),
                            lexeme: lexeme)
        try stateMachine?.tokenizer?.add(token)
    }
}

final class CommentOrSymbol: State {
    
    private var lexeme: String = ""
    
    init(_ char: String) {
        lexeme.append(char)
    }
    
    override func eat(_ char: String) throws {
        if char == "/" {
            let newState = Comment()
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else {
            let newState = SymbolState(lexeme)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        }
    }
}

final class Comment: State {
    
    override func eat(_ char: String) throws {
        if char == "\n" {
            let newState = Initial()
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        }
    }
}

final class StateMachine {
    
    var state: State
    weak var tokenizer: TokenizerV2?
    
    init() {
        state = Initial()
        state.stateMachine = self
    }
    
    func eat(_ char: String) throws {
        try state.eat(char)
    }
    
    func endOfString() throws {
        try state.endOfString()
    }
}
