//
//  EpisodeService.swift
//  AnimeCore
//
//  Created by Alexandre Mantovani Tavares on 25/12/18.
//

import Foundation
import Futures
import Kanna
import Nappa

class EpisodeService {
    enum API {
        static let url = Constants.config.apiHost.appendingPathComponent("api.php")
    }

    private let service: HTTPService
    public init(httpService: HTTPService = HTTPService()) {
        service = httpService
    }

    func getEpisodesFor(showID: String) -> Future<[Episode]> {
        return getEpisodesHelper(page: 0, showID: showID, episodes: [])
    }

    private func getEpisodesHelper(page: Int, showID: String, episodes: [Episode]) -> Future<[Episode]> {
        var episodes = episodes
        return getEpisodesFor(page: page, showID: showID).then { [unowned self] (eps) -> Future<[Episode]> in
            if eps.isEmpty {
                return Future(fulfilledWith: episodes)
            }
            episodes.append(contentsOf: eps)
            return self.getEpisodesHelper(page: page + 1, showID: showID, episodes: episodes)
        }
    }

    private func getEpisodesFor(page: Int, showID: String) -> Future<[Episode]> {
        let promise = Promise<[Episode]>()
        let parameters: Parameters = [
            "method": "getshows",
            "type": "show",
            "showid": showID,
            "nextid": page.description,
            "_": Date().timeIntervalSince1970,
        ]
        log.debug("Getting page \(page) for show with ID \(showID)")
        service.request(method: .get, url: API.url.absoluteString, payload: parameters)
            .responseString { response in
                do {
                    let html = try response.result.get()
                    let doc = try Kanna.HTML(html: html, encoding: .utf8)
                    let episodes = [Episode].init(from: doc)
                    promise.fulfill(episodes)
                } catch {
                    promise.reject(error)
                }
            }
        return promise.future
    }
}
