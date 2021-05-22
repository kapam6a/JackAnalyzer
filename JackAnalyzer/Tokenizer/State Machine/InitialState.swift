//
//  InitialState.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 25.04.2021.
//

import Foundation

final class InitialState: State {
    
    override func eat(_ char: String) throws -> Bool {
        if Character(char).isNumber {
            let newState = TransitionalIntegerLiteralState(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else if char == "\"" {
            let newState = TransitionalStringLiteralState(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else if char == "/" {
            let newState = TransitionalCommentOrSymbolState(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else if symbols.keys.contains(char) {
            let newState = SymbolState(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else if !controlCharacters.contains(char) {
            let newState = TransitionalIdentifierOrKeywordState(char)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        }
        
        return true
    }
}
