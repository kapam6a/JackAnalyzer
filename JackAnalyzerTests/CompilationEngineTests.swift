//
//  CompilationEngineTests.swift
//  JackAnalyzerTests
//
//  Created by Алексей Якименко on 18.04.2021.
//

import XCTest

class CompilationEngineTests: XCTestCase {

    func testCompileClass_returnsXML() throws {
        
        // given
        let code = """
        class Dog {
        }
        """
        let sut = compilationEngine(code)
        let expectedXML = """
            <class>
            <keyword>class</keyword>
            <identifier>Dog</identifier>
            <symbol>{</symbol>
            <symbol>}</symbol>
            </class>

            """
        
        // when
        try sut.compileClass()
        
        // then
        XCTAssertEqual(sut.xml(), expectedXML)
    }
    
    func testCompileClass_withField_returnsXML() throws {
        
        // given
        let code = """
        class Dog {
            field int a;
        }
        """
        let sut = compilationEngine(code)
        let expectedXML = """
            <class>
            <keyword>class</keyword>
            <identifier>Dog</identifier>
            <symbol>{</symbol>
            <classVarDec>
            <keyword>field</keyword>
            <keyword>int</keyword>
            <identifier>a</identifier>
            <symbol>;</symbol>
            </classVarDec>
            <symbol>}</symbol>
            </class>
            """
        
        // when
        try sut.compileClass()
        
        // then
        XCTAssertEqual(sut.xml(), expectedXML)
    }
    
    func testCompileClass_withFewFields_returnsXML() throws {
        
        // given
        let code = """
        class Dog {
            field int a, b;
        }
        """
        let sut = compilationEngine(code)
        let expectedXML = """
            <class>
            <keyword>class</keyword>
            <identifier>Dog</identifier>
            <symbol>{</symbol>
            <classVarDec>
            <keyword>field</keyword>
            <keyword>int</keyword>
            <identifier>a</identifier>
            <symbol>;</symbol>
            </classVarDec>
            <symbol>}</symbol>
            </class>
            """
        
        // when
        try sut.compileClass()
        
        // then
        XCTAssertEqual(sut.xml(), expectedXML)
    }
}

extension CompilationEngineTests {
    
    func compilationEngine(_ code: String) -> CompilationEngine {
        CompilationEngine(Tokenizer(code))
    }
}
