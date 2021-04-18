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
    case identifier
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

enum Symbol {
    case openingCurlyBracket // {
    case closingCurlyBracket // }
    case openingRoundBracket // (
    case closingRoundBracket // )
    case openingSquareBracket // [
    case closingSquareBracket // ]
    case dot // .
    case comma // ,
    case simecolons // ;
    case plusSign // +
    case minusSign // -
    case multiplicationSign // *
    case divisionSign // /
    case ampersand // &
    case verticalBar // |
    case less // <
    case more // >
    case equal // =
    case tilde // ~
}

enum TokenizerError: Error {
    case wrongKeyword(value: String?)
    case wrongSymbol(value: String?)
    case wrongIntVal(value: String?)
    case wrongStringVal(value: String?)
    case wrongIdentifier(value: String?)
}

final class Tokenizer {
    
    private let code: String
    private var currentIndex: Int = 0
    private var currentToken: String?
    private var nextToken: String?
    private let symbols: [String: Symbol] = [
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
    private let keywords: [String: Keyword] = [
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

    init(_ code: String) {
        self.code = code
    }
    
    func hasMoreTokens() -> Bool {
        while(!isEnd()) {
            if isWhitespacesOrNewlines() {
                currentIndex += 1
            } else if code[currentIndex] == "/" {
                skipComment()
            } else {
                return true
            }
        }
        return false
    }
    
    func advance() {
        if isSymbol() {
            extractSymbol()
        } else {
            extractWord()
        }
    }
    
    func tokenType() -> Token {
        if currentToken!.hasPrefix("\"") {
            return .stringConst
        } else if Int(currentToken!) != nil {
            return .intConst
        } else if symbols.keys.contains(currentToken!) {
            return .symbol
        } else if keywords.keys.contains(currentToken!) {
            return .keyword
        } else {
            return .identifier
        }
    }
    
    func keyword() throws -> Keyword {
        if let keyword = keywords[currentToken!] {
            return keyword
        } else {
            throw TokenizerError.wrongKeyword(value: currentToken)
        }
    }
    
    func symbol() throws -> Symbol {
        if let symbol = symbols[currentToken!] {
            return symbol
        } else {
            throw TokenizerError.wrongSymbol(value: currentToken)
        }
    }
    
    func identifier() throws -> String {
        if let currentToken = currentToken {
            return currentToken
        } else {
            throw TokenizerError.wrongIdentifier(value: currentToken)
        }
    }
    
    func intVal() throws -> Int {
        switch Int(currentToken!) {
        case .some(let value): return value
        default: throw TokenizerError.wrongSymbol(value: currentToken)
        }
    }
    
    func stringVal() throws -> String {
        if currentToken?.hasPrefix("\"") == true,
           currentToken?.hasSuffix("\"") == true {
           return String(currentToken!.dropFirst().dropLast())
        } else {
            throw TokenizerError.wrongStringVal(value: currentToken)
        }
    }
}

private extension Tokenizer {
    
    func extractSymbol() {
        let currentSymbol = code[currentIndex]
        currentToken = currentSymbol
        currentIndex += 1
    }

    func extractWord() {
        let start = currentIndex
        while(!isWhitespacesOrNewlines() && !isEnd() && !isSymbol()) {
            currentIndex += 1
        }
        currentToken = code[start..<currentIndex]
    }
    
    func isWhitespacesOrNewlines() -> Bool {
       [" ", "\n", "\t"].contains(code[currentIndex])
    }
    
    func isSymbol() -> Bool {
        symbols.keys.contains(code[currentIndex])
    }
    
    func skipComment() {
        while(code[currentIndex] != "\n" && !isEnd()) {
            currentIndex += 1
        }
    }
    
    func isEnd() -> Bool {
        currentIndex >= code.length
    }
}
