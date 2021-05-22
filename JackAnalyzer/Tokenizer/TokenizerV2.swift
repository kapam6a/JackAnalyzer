//
//  TokenizerV2.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 18.04.2021.
//

import Foundation

enum TokenType: Equatable {
    case keyword(Keyword)
    case symbol(Symbol)
    case identifier(String)
    case intConst(Int)
    case stringConst(String)
}

struct TokenV2: Equatable {
    let type: TokenType
    let lexeme: String
}

final class TokenizerV2 {
    
    private let code: String
    private var tokens: [TokenV2] = []
    private var currentIndex: Int = 0
    private var stateMachine: StateMachine

    init(_ code: String) {
        self.code = code
        self.stateMachine = StateMachine()
        self.stateMachine.tokenizer = self
    }
    
    func scanTokens() throws -> [TokenV2] {
        while(!isEnd()) {
            let currentSymbol = code[currentIndex]
            while try !stateMachine.eat(currentSymbol) {
                stateMachine = StateMachine()
                stateMachine.tokenizer = self
            }
            currentIndex += 1
        }
        try stateMachine.endOfString()
        return tokens
    }
    
    func add(_ token: TokenV2) {
        tokens.append(token)
    }
}

extension TokenizerV2 {
    
    func isEnd() -> Bool {
        currentIndex >= code.length
    }
}
