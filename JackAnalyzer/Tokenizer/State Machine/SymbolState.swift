//
//  File.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 25.04.2021.
//

import Foundation

final class SymbolState: State {
    
    private let lexeme: String
    
    init(_ char: String) {
        self.lexeme = char
    }
    
    override func enter() {
        let token = TokenV2(type: .symbol(symbols[lexeme]!),
                            lexeme: lexeme)
        stateMachine?.tokenizer?.add(token)
    }
}
