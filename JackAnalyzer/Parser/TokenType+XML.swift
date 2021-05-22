//
//  TokenType+XML.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 22.05.2021.
//

import Foundation

extension TokenType {
    
    func startTag() -> String {
        switch self {
        case .keyword(_): return "<keyword>"
        case .symbol(_): return "<symbol>"
        case .identifier(_): return "<identifier>"
        case .intConst(_): return "<symbol>"
        case .stringConst(_): return "<symbol>"
        }
    }
    
    func content() -> String {
        switch self {
        case .keyword(let keyword):
            switch keyword {
            case .`class`: return "class"
            case .method: return "method"
            case .function: return "function"
            case .constructor: return "constructor"
            case .int: return "int"
            case .boolean: return "boolean"
            case .char: return "char"
            case .void: return "void"
            case .`var`: return "var"
            case .`static`: return "static"
            case .field: return "field"
            case .`let`: return "let"
            case .`do`: return "do"
            case .`if`: return "if"
            case .`else`: return "else"
            case .`while`: return "while"
            case .`return`: return "return"
            case .`true`: return "true"
            case .`false`: return "false"
            case .null: return "null"
            case .this: return "this"
            }
        case .symbol(let symbol):
            switch symbol {
            case .openingCurlyBracket: return "{"
            case .closingCurlyBracket: return "}"
            case .openingRoundBracket: return "("
            case .closingRoundBracket: return ")"
            case .openingSquareBracket: return "["
            case .closingSquareBracket: return "]"
            case .dot: return "."
            case .comma: return ","
            case .simecolons: return ";"
            case .plusSign: return "+"
            case .minusSign: return "-"
            case .multiplicationSign: return "*"
            case .divisionSign: return "/"
            case .ampersand: return "&"
            case .verticalBar: return "|"
            case .less: return "<"
            case .more: return ">"
            case .equal: return "="
            case .tilde: return "~"
            }
        case .identifier(let identifier): return identifier
        case .intConst(let int): return String(int)
        case .stringConst(let string): return string
        }
    }
    
    func endTag() -> String {
        switch self {
        case .keyword(_): return "</keyword>\n"
        case .symbol(_): return "</symbol>\n"
        case .identifier(_): return "</identifier>\n"
        case .intConst(_): return "</symbol>\n"
        case .stringConst(_): return "</symbol>\n"
        }
    }
}
