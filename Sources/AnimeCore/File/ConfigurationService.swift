//
//  ConfigurationService.swift
//  AnimeCore
//
//  Created by Alexandre Mantovani Tavares on 25/12/18.
//

import Foundation
import Futures

class ConfigurationService {
    private let fileService: FileService

    init(fileService: FileService = FileService()) {
        self.fileService = fileService
    }

    func getConfiguration() -> Configuration {
        guard let data = fileService.readFile(at: Constants.Files.config.absoluteString) else {
            fatalError("Config file doesn't exist at path \(Constants.Files.config)")
        }
        return try! JSONDecoder().decode(Configuration.self, from: data)
    }

}
