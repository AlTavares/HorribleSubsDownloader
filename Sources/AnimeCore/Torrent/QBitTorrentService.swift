//
//  QBitTorrentService.swift
//  AnimeCore
//
//  Created by Alexandre Mantovani Tavares on 24/02/19.
//

import Foundation
import Futures
import Nappa

class QBitTorrentService {
    let api: URL
    let service = HTTPService()
    init(api: URL) {
        self.api = api
    }

    enum Errors: Error {
        case couldNotAddTorrent
    }

    func addTorrent(magnet: String, show: String) -> Future<Void> {
        let url = api.appendingPathComponent("torrents/add").absoluteString
        let parameters: Parameters = [
            "category": "Anime/\(show)",
            "urls": magnet
        ]
        let promise = Promise<Void>()

        service.request(method: .post, url: url, payload: parameters, parameterEncoding: .form).responseData { response in
            guard response.response?.statusCode == 200 else {
                return promise.reject(Errors.couldNotAddTorrent)
            }
            promise.fulfill()
        }
        return promise.future
    }
}
