//
//  FileService.swift
//  AnimeCore
//
//  Created by Alexandre Mantovani Tavares on 25/12/18.
//

import Foundation

class FileService {
    private let fileManager = FileManager()

    init(currentDirectory: String? = nil) {
        guard let directory = currentDirectory else { return }
        fileManager.changeCurrentDirectoryPath(directory)
    }

    func readFile(at path: String) -> Data? {
        return fileManager.contents(atPath: path)
    }

    func writeJSONFile<T: Encodable>(at path: String, contents: T) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted

            let data = try encoder.encode(contents)
            let url = URL(fileURLWithPath: fileManager.currentDirectoryPath)
            try data.write(to: url.appendingPathComponent(path))

        } catch {
            log.error(error)
        }
    }

    func createDirectory(name: String) {
        try? fileManager.createDirectory(atPath: name, withIntermediateDirectories: true, attributes: nil)
    }
}
