//
//  File.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 25.04.2021.
//

import Foundation

final class TransitionalCommentOrSymbolState: State {
    
    private var lexeme: String = ""
    
    init(_ char: String) {
        lexeme.append(char)
    }
    
    override func eat(_ char: String) throws {
        if char == "/" {
            let newState = CommentState()
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        } else {
            let newState = SymbolState(lexeme)
            newState.stateMachine = stateMachine
            stateMachine?.state = newState
        }
    }
}
