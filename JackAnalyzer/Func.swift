//
//  Func.swift
//  JackAnalyzer
//
//  Created by Алексей Якименко on 16.04.2021.
//

import Foundation

func or(_ f1: @autoclosure () throws -> Void,
        _ f2: @autoclosure () throws -> Void) throws {
    do {
        try f1()
    } catch {
        try f2()
    }
}

func or(_ f1: @autoclosure () throws -> Void,
        _ f2: @autoclosure () throws -> Void,
        _ f3: @autoclosure () throws -> Void) throws {
    do {
        try f1()
    } catch {
        do {
            try f2()
        } catch {
            try f3()
        }
    }
}

func or(_ f1: @autoclosure () throws -> Void,
        _ f2: @autoclosure () throws -> Void,
        _ f3: @autoclosure () throws -> Void,
        _ f4: @autoclosure () throws -> Void) throws {
    do {
        try f1()
    } catch {
        do {
            try f2()
        } catch {
            do {
                try f3()
            } catch {
                try f4()
            }
        }
    }
}

func or(_ f1: @autoclosure () throws -> Void,
        _ f2: @autoclosure () throws -> Void,
        _ f3: @autoclosure () throws -> Void,
        _ f4: @autoclosure () throws -> Void,
        _ f5: @autoclosure () throws -> Void) throws {
    do {
        try f1()
    } catch {
        do {
            try f2()
        } catch {
            do {
                try f3()
            } catch {
                do {
                    try f4()
                } catch {
                    try f5()
                }
            }
        }
    }
}
