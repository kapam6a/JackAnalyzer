//
//  TokenizerV2Tests.swift
//  JackAnalyzerTests
//
//  Created by Алексей Якименко on 18.04.2021.
//

import XCTest

import XCTest

final class TokenizerV2Tests: XCTestCase {

    func testScanTokens_withOneIdentifier_returnsTokens() throws {
        
        // given
        let sut = TokenizerV2("Dog")
         
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .identifier("Dog"), lexeme: "Dog")])
    }
    
    func testScanTokens_withTwoIdentifiers_returnsTokens() throws {
        
        // given
        let sut = TokenizerV2("Dog eat")
         
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .identifier("Dog"), lexeme: "Dog"),
                                .init(type: .identifier("eat"), lexeme: "eat")])
    }
    
    func testScanTokens_withFewIdentifiersWithNewLines_returnsTokens() throws {
        
        // given
        let sut = TokenizerV2("Dog eat\n dog")
         
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .identifier("Dog"), lexeme: "Dog"),
                                .init(type: .identifier("eat"), lexeme: "eat"),
                                .init(type: .identifier("dog"), lexeme: "dog")])
    }
    
    func testScanTokens_withOneDigit_returnsTokens() throws {
        
        // given
        let sut = TokenizerV2("69696")
         
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .intConst(69696), lexeme: "69696")])
    }
    
    func testScanTokens_withTwoDigits_returnsTokens() throws {
        
        // given
        let sut = TokenizerV2("69696 56666")
         
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .intConst(69696), lexeme: "69696"),
                                .init(type: .intConst(56666), lexeme: "56666")])
    }
    
    func testScanTokens_withDigitContainsLetters_throwsError() throws {
        
        // given
        let sut = TokenizerV2("6969sss6")
        
        // then
        XCTAssertThrowsError(try sut.scanTokens())
    }
    
    func testScanTokens_withSymbol_returnTokens() throws {
        
        // given
        let sut = TokenizerV2("{")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .symbol(.openingCurlyBracket), lexeme: "{")])
    }
    
    func testScanTokens_withFewSymbols_returnTokens() throws {
        
        // given
        let sut = TokenizerV2("{}")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .symbol(.openingCurlyBracket), lexeme: "{"),
                                .init(type: .symbol(.closingCurlyBracket), lexeme: "}")])
    }
    
    func testScanTokens_withIndetifierAndSymbols_returnTokens() throws {
        
        // given
        let sut = TokenizerV2("Run()")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .identifier("Run"), lexeme: "Run"),
                                .init(type: .symbol(.openingRoundBracket), lexeme: "("),
                                .init(type: .symbol(.closingRoundBracket), lexeme: ")")])
    }
    
    func testScanTokens_withDigitAndSymbols_returnTokens() throws {
        
        // given
        let sut = TokenizerV2("56666>44")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .intConst(56666), lexeme: "56666"),
                                .init(type: .symbol(.more), lexeme: ">"),
                                .init(type: .intConst(44), lexeme: "44")])
    }
    
    func testScanTokens_withKeyword_returnTokens() throws {
        
        // given
        let sut = TokenizerV2("class")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .keyword(.class), lexeme: "class")])
    }
    
    func testScanTokens_withKeywordAndNotSupportedSymbol_returnTokens() throws {
        
        // given
        let sut = TokenizerV2("class#")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .identifier("class#"), lexeme: "class#")])
    }
    
    func testScanTokens_withKeywordIdentifierAndSymbols_returnTokens() throws {
        
        // given
        let sut = TokenizerV2("class Dog { }")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .keyword(.class), lexeme: "class"),
                                .init(type: .identifier("Dog"), lexeme: "Dog"),
                                .init(type: .symbol(.openingCurlyBracket), lexeme: "{"),
                                .init(type: .symbol(.closingCurlyBracket), lexeme: "}")])
    }
    
    func testScanTokens_withStringLiteral_returnTokens() throws {
        
        // given
        let sut = TokenizerV2("\"Moscow\"")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .stringConst("Moscow"), lexeme: "\"Moscow\"")])
    }
    
    func testScanTokens_withStringLiteralWithSymbol_returnTokens() throws {
        
        // given
        let sut = TokenizerV2("\"Moscow\";")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .stringConst("Moscow"), lexeme: "\"Moscow\""),
                                .init(type: .symbol(.simecolons), lexeme: ";")])
    }
    
    func testScanTokens_withComment_returnNoTokens() throws {
        
        // given
        let sut = TokenizerV2("// This code should be removed")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [])
    }
    
    func testScanTokens_withFewComments_returnNoTokens() throws {
        
        // given
        let sut = TokenizerV2("// This code should be removed \n // This code should be removed")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [])
    }
    
    func testScanTokens_withDivisionSign_returnTokens() throws {
        
        // given
        let sut = TokenizerV2("x=2/3")
        
        // when
        let result = try sut.scanTokens()
        
        // then
        XCTAssertEqual(result, [.init(type: .identifier("x"), lexeme: "x"),
                                .init(type: .symbol(.equal), lexeme: "="),
                                .init(type: .intConst(2), lexeme: "2"),
                                .init(type: .symbol(.divisionSign), lexeme: "/"),
                                .init(type: .intConst(3), lexeme: "3")])
    }
}

extension TokenizerV2Tests {
    
    func tokenizer(_ code: String) -> TokenizerV2 {
        TokenizerV2(code)
    }
}
