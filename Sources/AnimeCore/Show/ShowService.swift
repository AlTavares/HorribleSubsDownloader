//
//  ShowService.swift
//  anime
//
//  Created by Alexandre Mantovani Tavares on 23/12/18.
//

import Foundation
import Futures
import Kanna
import Nappa

class ShowService {
    enum API {
        static let url = Constants.config.apiHost.appendingPathComponent("shows")
    }

    private let fileService = FileService()
    private let service: HTTPService
    private let episodeService: EpisodeService
    public init(httpService: HTTPService = HTTPService(), episodeService: EpisodeService = EpisodeService()) {
        service = httpService
        self.episodeService = episodeService
    }

    func getShow(slug: String) -> Future<Show> {
        let promise = Promise<Show>()
        let url = API.url.appendingPathComponent(slug).absoluteString
        service.request(method: .get, url: url).responseString { response in
            do {
                let html = try response.result.get()
                let doc = try Kanna.HTML(html: html, encoding: .utf8)
                log.debug("Parsing page \(doc.title ?? "without title")")
                var show = Show(from: doc, slug: slug)
                self.episodeService.getEpisodesFor(showID: show.id).whenFulfilled { episodes in
                    show.episodes = episodes
                    promise.fulfill(show)
                }

            } catch {
                promise.reject(error)
            }
        }
        return promise.future
    }

    func getDownloadedEpisodes(for show: Show) -> [Int] {
        guard let data = fileService.readFile(at: path(for: show)) else { return [] }
        return (try? JSONDecoder().decode(Array<Int>.self, from: data)) ?? []
    }

    func saveAddedEpisodes(for show: Show, episodes: [Episode]) {
        let contents = episodes.map { $0.number }.sorted()
        fileService.writeJSONFile(at: path(for: show), contents: contents)
    }

    private func path(for show: Show) -> String {
        return Constants.Files.showPath.appendingPathComponent(show.slug + ".json").absoluteString
    }
}
