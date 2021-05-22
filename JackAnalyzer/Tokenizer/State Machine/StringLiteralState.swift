//
//  StringLiteralState.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 25.04.2021.
//

import Foundation

final class StringLiteralState: State {
    
    private let lexeme: String
    
    init(_ lexeme: String) {
        self.lexeme = lexeme
    }
    
    override func enter() {
        let string = String(lexeme.dropFirst().dropLast())
        let token = TokenV2(type: .stringConst(string),
                            lexeme: lexeme)
        stateMachine?.tokenizer?.add(token)
    }
}
