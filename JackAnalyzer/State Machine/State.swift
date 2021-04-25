//
//  State.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 25.04.2021.
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
    func enter() {}
}
