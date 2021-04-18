//
//  JackAnalyzerTests.swift
//  JackAnalyzerTests
//
//  Created by Алексей Якименко on 18.04.2021.
//

import XCTest

class TokenizerTests: XCTestCase {

    func testHasMoreTokens_withEmptyString_returnsFalse() throws {
        
        // given
        let sut = Tokenizer("")
         
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertFalse(result)
    }
    
    func testHasMoreTokens_withSpace_returnsFalse() throws {
        
        // given
        let sut = Tokenizer(" ")
         
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertFalse(result)
    }
    
    func testHasMoreTokens_withComment_returnsFalse() throws {
        
        // given
        let sut = Tokenizer("// This code should be removed")
         
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertFalse(result)
    }
    
    func testHasMoreTokens_withFewComments_returnsFalse() throws {
        
        // given
        let sut = Tokenizer("// This code should be removed\n // This code should be removed")
         
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertFalse(result)
    }
    
    func testHasMoreTokens_withOneAlpha_returnsTrue() throws {
        
        // given
        let sut = Tokenizer("a")
         
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertTrue(result)
    }
    
    func testHasMoreTokens_withFewAlphas_returnsTrue() throws {
        
        // given
        let sut = Tokenizer("Some")
         
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertTrue(result)
    }
    
    func testHasMoreTokens_withOneDigit_returnsTrue() throws {
        
        // given
        let sut = Tokenizer("6")
         
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertTrue(result)
    }
    
    func testHasMoreTokens_withFewDigits_returnsTrue() throws {
        
        // given
        let sut = Tokenizer("67343")
         
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertTrue(result)
    }
    
    func testHasMoreTokens_withOneWord_returnsFalseForEOS() throws {
        
        // given
        let sut = Tokenizer("67343")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertFalse(result)
    }
    
    func testHasMoreTokens_withFewWords_returnsTrueForLastToken() throws {
        
        // given
        let sut = Tokenizer("Some 67343")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertTrue(result)
    }
    
    func testHasMoreTokens_withFewWords_returnsFalseForEOS() throws {
        
        // given
        let sut = Tokenizer("Some 67343")
        _ = sut.hasMoreTokens()
        sut.advance()
        _ = sut.hasMoreTokens()
        sut.advance()
        
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertFalse(result)
    }
    
    func testHasMoreTokens_withFewCommentsAndFewWords_returnsTrueForLastToken() throws {
        
        // given
        let sut = Tokenizer("// This code should be removed\n Some 56432")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = sut.hasMoreTokens()
        
        // then
        XCTAssertTrue(result)
    }
    
    func testTokenType_withStringLiteral_returnsStringConst() throws {
        
        // given
        let sut = Tokenizer("\"Bob\"")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = sut.tokenType()
        
        // then
        XCTAssertEqual(result, .stringConst)
    }
    
    func testTokenType_withDigit_returnsIntConst() throws {
        
        // given
        let sut = Tokenizer("4566")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = sut.tokenType()
        
        // then
        XCTAssertEqual(result, .intConst)
    }
    
    func testTokenType_withSymbol_returnsSymbol() throws {
        
        // given
        let sut = Tokenizer("{")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = sut.tokenType()
        
        // then
        XCTAssertEqual(result, .symbol)
    }
    
    func testTokenType_withKeyword_returnsKeyword() throws {
        
        // given
        let sut = Tokenizer("class")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = sut.tokenType()
        
        // then
        XCTAssertEqual(result, .keyword)
    }
    
    func testTokenType_withKeywordAndSpace_returnsKeyword() throws {
        
        // given
        let sut = Tokenizer("class ")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = sut.tokenType()
        
        // then
        XCTAssertEqual(result, .keyword)
    }
    
    func testTokenType_withIdentifier_returnsIdentifier() throws {
        
        // given
        let sut = Tokenizer("class1")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = sut.tokenType()
        
        // then
        XCTAssertEqual(result, .identifier)
    }
    
    func testIdentifier_returnsValue() throws {
        
        // given
        let sut = Tokenizer("class1")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = try sut.identifier()
        
        // then
        XCTAssertEqual(result, "class1")
    }
    
    func testStringVal_returnsValue() throws {
        
        // given
        let sut = Tokenizer("\"Bob\"")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = try sut.stringVal()
        
        // then
        XCTAssertEqual(result, "Bob")
    }
    
    func testIntVal_returnsValue() throws {
        
        // given
        let sut = Tokenizer("5674")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = try sut.intVal()
        
        // then
        XCTAssertEqual(result, 5674)
    }
    
    func testKeyword_returnsValue() throws {
        
        // given
        let sut = Tokenizer("class")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = try sut.keyword()
        
        // then
        XCTAssertEqual(result, .class)
    }
    
    func testSymbol_returnsValue() throws {
        
        // given
        let sut = Tokenizer("{")
        _ = sut.hasMoreTokens()
        sut.advance()
         
        // when
        let result = try sut.symbol()
        
        // then
        XCTAssertEqual(result, .openingCurlyBracket)
    }
}

extension TokenizerTests {
    
    func tokenizer(_ code: String) -> Tokenizer {
        Tokenizer(code)
    }
}
