//
//  Watcher.swift
//  AnimeCore
//
//  Created by Alexandre Mantovani Tavares on 24/02/19.
//

import Foundation

public class Watcher {
    let showService = ShowService()
    let timer: DispatchSourceTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    let torrentService = QBitTorrentService(api: Constants.config.qbittorrent.api)
    public init() {}

    public func watch() {
        log.info("Starting watcher")

        timer.schedule(deadline: .now(), repeating: .seconds(20 * 60))
        timer.setEventHandler {
            let watchList = ConfigurationService().getConfiguration().watchList.filter { $0.active }

            let showGroup = DispatchGroup()
            watchList.forEach { watchListShow in
                showGroup.enter()
                self.showService.getShow(slug: watchListShow.slug).whenFulfilled { show in
                    let downloadedEpisodes = Set(self.showService.getDownloadedEpisodes(for: show))
                    let episodes = show.episodes.filter { episode in
                        guard episode.number >= watchListShow.minimumEpisode else { return false }
                        guard !downloadedEpisodes.contains(episode.number) else { return false }
                        return true
                    }.sorted { $0.number < $1.number }
                    self.addTorrents(for: episodes, show: show)
                    showGroup.leave()
                }
            }
        }
        timer.resume()
    }

    private func addTorrents(for episodes: [Episode], show: Show) {
        let episodeGroup = DispatchGroup()
        var downloaded: [Episode] = []
        episodes.forEach { episode in
            episodeGroup.enter()
            guard let magnet = episode.fullHD?.magnet else { return }
            self.torrentService.addTorrent(magnet: magnet, show: show.name).whenResolved { result in
                switch result {
                case .fulfilled:
                    let message = "\nAdded torrent:\n\(show.name)\nEpisode: \(episode.number)"
                    log.info(message)
                    nimrod.send(message: message)
                    downloaded.append(episode)
                case .rejected(let error):
                    log.error(error)
                }
                episodeGroup.leave()
            }
        }
        episodeGroup.wait()
        log.info("Finished adding episodes for \(show.name)")
        showService.saveAddedEpisodes(for: show, episodes: downloaded)
    }
}
