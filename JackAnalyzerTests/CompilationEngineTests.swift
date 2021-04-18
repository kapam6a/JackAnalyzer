//
//  CompilationEngineTests.swift
//  JackAnalyzerTests
//
//  Created by Алексей Якименко on 18.04.2021.
//

import XCTest

class CompilationEngineTests: XCTestCase {

    func testCompileReturn_returnsXML() throws {
        
        // given
        let code = """
        class Dog {
        
        }
        """
        let sut = compilationEngine(code)
        
        // when
        try sut.compileClass()
        
        // then
        XCTAssertEqual(
            sut.xml(),
            """
            <class>
                <keyword>class</keyword>
                <identifier>Dog</identifier>
            </class>
            """
        )
    }
}

extension CompilationEngineTests {
    
    func compilationEngine(_ code: String) -> CompilationEngine {
        CompilationEngine(Tokenizer(code))
    }
}
