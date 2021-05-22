//
//  CompilationEngineV2.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 02.05.2021.
//

enum ParserError: Error {
    case wrongToken(TokenV2)
}

final class Parser {
    
    private var ast: String = ""
    private var currentIndex: Int = 0
    private let tokens: [TokenV2]
    
    init(_ tokens: [TokenV2]) {
        self.tokens = tokens
    }
    
    func parse() throws -> String {
        try parseClass()
        return ast
    }
}

private extension Parser {
    
    func parseClass() throws {
        ast.append("<class>\n")
        if case .keyword(.class) = tokens[currentIndex].type {
            writeIntoAst()
        } else {
            throw ParserError.wrongToken(tokens[currentIndex])
        }
        
        currentIndex += 1
        if case .identifier(_) = tokens[currentIndex].type {
            writeIntoAst()
        } else {
            throw ParserError.wrongToken(tokens[currentIndex])
        }
        
        currentIndex += 1
        if case .symbol(.openingCurlyBracket) = tokens[currentIndex].type {
            writeIntoAst()
        } else {
            throw ParserError.wrongToken(tokens[currentIndex])
        }
        
        currentIndex += 1
        try parseClassVarDec()
        
        try parseSubroutineDec()
        
        if case .symbol(.closingCurlyBracket) = tokens[currentIndex].type {
            writeIntoAst()
        } else {
            throw ParserError.wrongToken(tokens[currentIndex])
        }

        ast.append("</class>")
    }
    
    func parseClassVarDec() throws {
        while (tokens[currentIndex].type == .keyword(.static) ||
               tokens[currentIndex].type == .keyword(.field)) {
            writeIntoAst()
            
            currentIndex += 1
            try parseType()
            
            if case .identifier(_) = tokens[currentIndex].type {
                writeIntoAst()
            } else {
                throw ParserError.wrongToken(tokens[currentIndex])
            }
            
            currentIndex += 1
            while tokens[currentIndex].type == .symbol(.comma) {
                writeIntoAst()
                
                currentIndex += 1
                try parseType()
                
                if case .identifier(_) = tokens[currentIndex].type {
                    writeIntoAst()
                } else {
                    throw ParserError.wrongToken(tokens[currentIndex])
                }
                currentIndex += 1
            }
            
            if case .symbol(.simecolons) = tokens[currentIndex].type {
                writeIntoAst()
            } else {
                throw ParserError.wrongToken(tokens[currentIndex])
            }
            currentIndex += 1
        }
    }
    
    func parseSubroutineDec() throws {
        
    }
    
    func parseType() throws {
        switch tokens[currentIndex].type {
        case .keyword(let keyword):
            switch keyword {
            case .char, .int, .boolean:
                writeIntoAst()
            default:
                throw ParserError.wrongToken(tokens[currentIndex])
            }
        case .identifier(_):
            writeIntoAst()
        default:
            throw ParserError.wrongToken(tokens[currentIndex])
        }
        currentIndex += 1
    }
}

private extension Parser {
    
    func writeIntoAst() {
        let currentType = tokens[currentIndex].type
        ast.append(currentType.startTag())
        ast.append(currentType.content())
        ast.append(currentType.endTag())
    }
}
