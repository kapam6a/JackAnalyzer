//
//  Func.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 16.04.2021.
//

import Foundation

enum OrError: Error {
    case failed
}

func or(_ f1: @escaping @autoclosure () throws -> Void,
        _ f2: @escaping @autoclosure () throws -> Void) throws {
    try _or(f1, f2)
}

func or(_ f1: @escaping @autoclosure () throws -> Void,
        _ f2: @escaping @autoclosure () throws -> Void,
        _ f3: @escaping @autoclosure () throws -> Void) throws {
    try _or(f1, f2, f3)
}

func or(_ f1: @escaping @autoclosure () throws -> Void,
        _ f2: @escaping @autoclosure () throws -> Void,
        _ f3: @escaping @autoclosure () throws -> Void,
        _ f4: @escaping @autoclosure () throws -> Void) throws {
    try _or(f1, f2, f3, f4)
}

func or(_ f1: @escaping @autoclosure () throws -> Void,
        _ f2: @escaping @autoclosure () throws -> Void,
        _ f3: @escaping @autoclosure () throws -> Void,
        _ f4: @escaping @autoclosure () throws -> Void,
        _ f5: @escaping @autoclosure () throws -> Void) throws {
    try _or(f1, f2, f3, f4, f5)
}

private func _or(_ functions: () throws -> Void...) throws {
    for f in functions {
        do {
            try f()
            break
        } catch {}
    }
    throw OrError.failed
}
