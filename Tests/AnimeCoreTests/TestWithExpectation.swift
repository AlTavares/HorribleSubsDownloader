//
//  TestWithExpectation.swift
//  AnimeCoreTests
//
//  Created by Alexandre Mantovani Tavares on 24/12/18.
//

import XCTest

class TestWithExpectation: XCTestCase {
    var expectation: XCTestExpectation!

    func createExpectation() {
        expectation = expectation(description: "Expectation fulfilled")
    }

    func waitUntilDone(timeout: Double = 1) {
        waitForExpectations(timeout: timeout, handler: nil)
    }

    func done() {
        expectation.fulfill()
    }
}

