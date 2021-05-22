//
//  StateMachine.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 18.04.2021.
//

import Foundation

final class StateMachine {
    
    var state: State {
        didSet {
            state.enter()
        }
    }
    weak var tokenizer: TokenizerV2?
    
    init() {
        state = InitialState()
        state.stateMachine = self
    }
    
    @discardableResult func eat(_ char: String) throws -> Bool {
        try state.eat(char)
    }
    
    func endOfString() throws {
        try state.endOfString()
    }
}
