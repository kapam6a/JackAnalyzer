//
//  File.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 25.04.2021.
//

import Foundation

final class CommentState: State {
    
    override func eat(_ char: String) throws -> Bool {
        if char == "\n" {
            return false
        }
        return true
    }
}
