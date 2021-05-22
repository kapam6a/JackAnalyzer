//
//  File.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 25.04.2021.
//

import Foundation

final class TransitionalIntegerLiteralState: State {
    
    enum DigitError: Error {
        case notSupportedSymbol
    }
    
    private var lexeme: String = ""
    
    init(_ char: String) {
        lexeme.append(char)
    }
    
    override func eat(_ char: String) throws -> Bool {
        if symbols.keys.contains(char) || controlCharacters.contains(char) {
            switchToFinalState()
            return false
        } else if Character(char).isNumber {
            lexeme.append(char)
            return true
        } else {
            throw DigitError.notSupportedSymbol
        }
    }
    
    override func endOfString() throws {
        switchToFinalState()
    }
    
    func switchToFinalState() {
        let newState = IntegerLiteralState(lexeme)
        newState.stateMachine = stateMachine
        stateMachine?.state = newState
    }
}
