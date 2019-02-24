//
//  ConfigurationModel.swift
//  AnimeCore
//
//  Created by Alexandre Mantovani Tavares on 25/12/18.
//

import Foundation

struct Configuration: Codable {
    let watchList: [WatchList]
    let apiHost: URL
    let downloadsDirectory: URL
    let nimrodKey: String
    let qbittorrent: QBitTorrent
}

struct QBitTorrent: Codable {
    let api: URL
}

struct WatchList: Codable {
    let name: String
    let slug: String
    let minimumEpisode: Int
    let active: Bool
}
