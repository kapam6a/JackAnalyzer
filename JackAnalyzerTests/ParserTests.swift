//
//  File.swift
//  JackAnalyzerTests
//
//  Created by Алексей Якименко on 03.05.2021.
//

import XCTest

class ParserTests: XCTestCase {

    func testParseClass_returnsXML() throws {
        
        // given
        let tokens: [TokenV2] = [.init(type: .keyword(.class), lexeme: "class"),
                                 .init(type: .identifier("Builder"), lexeme: "Builder"),
                                 .init(type: .symbol(.openingCurlyBracket), lexeme: "{"),
                                 .init(type: .symbol(.closingCurlyBracket), lexeme: "}")]
        let sut = Parser(tokens)
        
        // when
        let result = try sut.parse()
        
        // then
        XCTAssertEqual(
            result,
            """
            <class>
            <keyword>class</keyword>
            <identifier>Builder</identifier>
            <symbol>{</symbol>
            <symbol>}</symbol>
            </class>
            """
        )
    }
    
    func testParseClassVarDec_returnsXML() throws {
        
        // given
        let tokens: [TokenV2] = [.init(type: .keyword(.class), lexeme: "class"),
                                 .init(type: .identifier("Builder"), lexeme: "Builder"),
                                 .init(type: .symbol(.openingCurlyBracket), lexeme: "{"),
                                 .init(type: .keyword(.static), lexeme: "static"),
                                 .init(type: .keyword(.char), lexeme: "char"),
                                 .init(type: .identifier("name"), lexeme: "name"),
                                 .init(type: .symbol(.comma), lexeme: ","),
                                 .init(type: .keyword(.boolean), lexeme: "boolean"),
                                 .init(type: .identifier("isReady"), lexeme: "isReady"),
                                 .init(type: .symbol(.simecolons), lexeme: ";"),
                                 .init(type: .symbol(.closingCurlyBracket), lexeme: "}")]
        let sut = Parser(tokens)
        
        // when
        let result = try sut.parse()
        
        // then
        XCTAssertTrue(
            result.contains(
            """
            <keyword>static</keyword>
            <keyword>char</keyword>
            <identifier>name</identifier>
            <symbol>,</symbol>
            <keyword>boolean</keyword>
            <identifier>isReady</identifier>
            <symbol>;</symbol>
            """
            )
        )
    }
}
