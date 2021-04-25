//
//  KeywordState.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 25.04.2021.
//

import Foundation

final class KeywordState: State {
    
    private let lexeme: String
    
    init(_ lexeme: String) {
        self.lexeme = lexeme
    }
    
    override func enter() {
        let token = TokenV2(type: .keyword(keywords[lexeme]!),
                            lexeme: lexeme)
        stateMachine?.tokenizer?.add(token)
    }
}
