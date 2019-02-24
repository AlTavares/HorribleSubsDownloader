//
//  ShowTests.swift
//  animeTests
//
//  Created by Alexandre Mantovani Tavares on 24/12/18.
//

@testable import AnimeCore
import Foundation
import Futures
import Nappa
import XCTest

final class ShowTests: TestWithExpectation {
    var httpService = HTTPService()

    func testExample() {
        print("Testing")
        let slug = "golden-kamuy"
        let showService = ShowService(httpService: httpService)
        createExpectation()
        showService.getShow(slug: slug).whenFulfilled { show in
            print(show)
            XCTAssertEqual(show.id, "1090")
            XCTAssertEqual(show.name, "Golden Kamuy")
            XCTAssertEqual(show.slug, "golden-kamuy")
            XCTAssertEqual(show.episodes.count, 24)
            self.done()
        }
        waitUntilDone(timeout: 5)
    }

    func testConfig() {
        let currentPath = "/Users/alexandre/Documents/go/src/github.com/AlTavares/Anime"
        let configService = ConfigurationService(fileService: FileService(currentDirectory: currentPath))
        let config = configService.getConfiguration()
        log.debug(config)
        FileService().writeJSONFile(at: "Teste.json", contents: config)
        
    }
}
