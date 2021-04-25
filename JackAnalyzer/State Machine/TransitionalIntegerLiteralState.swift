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
    
    override func eat(_ char: String) throws {
        if symbols.keys.contains(char) {
            let newState = SymbolState(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else if [" ", "\n", "\t"].contains(char) {
            switchToFinalState()
        } else if Character(char).isNumber {
            lexeme.append(char)
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
