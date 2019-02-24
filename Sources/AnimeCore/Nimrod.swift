//
//  Nimrod.swift
//  AnimeCore
//
//  Created by Alexandre Mantovani Tavares on 24/02/19.
//

import Foundation
import Nappa

let nimrod = Nimrod(apiKey: Constants.config.nimrodKey)
class Nimrod {
    let url = "https://www.nimrod-messenger.io/api/v1/message"
    let apiKey: String
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func send(message: String) {
        let parameters = [
            "api_key": apiKey,
            "message": message
        ]

        _ = HTTPService().request(method: .post, url: url, payload: parameters).perform()
    }
}
