//
//  File.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 25.04.2021.
//

import Foundation

final class TransitionalIdentifierOrKeywordState: State {
    
    private var lexeme: String = ""
    
    init(_ char: String) {
        lexeme.append(char)
    }
    
    override func eat(_ char: String) {
        if symbols.keys.contains(char) {
            let newState = SymbolState(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
            switchToFinalState()
        } else if [" ", "\n", "\t"].contains(char) {
            switchToFinalState()
        } else {
            lexeme.append(char)
        }
    }
    
    override func endOfString() {
        switchToFinalState()
    }
    
    private func switchToFinalState() {
        if keywords.keys.contains(lexeme) {
            let newState = KeywordState(lexeme)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else {
            let newState = IdentifierState(lexeme)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        }
    }
}
