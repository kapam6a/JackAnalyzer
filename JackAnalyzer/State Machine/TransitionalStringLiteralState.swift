//
//  File.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 25.04.2021.
//

import Foundation

final class TransitionalStringLiteralState: State {
    
    enum StringLiteralStateError: Error {
        case stringMustEndWithQuotes
    }
    
    private var lexeme: String = ""
    
    init(_ char: String) {
        lexeme.append(char)
    }
    
    override func eat(_ char: String) throws -> Bool {
        if lexeme.hasSuffix("\"") && lexeme.hasPrefix("\"") && lexeme.length > 1 {
            switchToFinalState()
            return false
        } else {
            lexeme.append(char)
            return true
        }
    }
    
    override func endOfString() throws {
        if lexeme.hasSuffix("\"") && lexeme.hasPrefix("\"") && lexeme.length > 1 {
            switchToFinalState()
        } else {
            throw StringLiteralStateError.stringMustEndWithQuotes
        }
    }
    
    func switchToFinalState() {
        let newState = StringLiteralState(lexeme)
        newState.stateMachine = stateMachine
        stateMachine?.state = newState
    }
}
