//
//  EpisodeModel.swift
//  AnimeCore
//
//  Created by Alexandre Mantovani Tavares on 25/12/18.
//

import Foundation
import Kanna
import Regex

struct Episode {
    private enum Selector: String {
        case number = "a > strong"
        case sd = ".link-480p"
        case hd = ".link-720p"
        case fullHD = ".link-1080p"
    }

    var number: Int = 0
    var sd: DownloadInfo?
    var hd: DownloadInfo?
    var fullHD: DownloadInfo?

    init(from element: Kanna.XMLElement) {
        self.number ?= self.episodeNumber(from: element.at_css(Selector.number)?.text)
        self.sd = DownloadInfo(from: element.at_css(Selector.sd))
        self.hd = DownloadInfo(from: element.at_css(Selector.hd))
        self.fullHD = DownloadInfo(from: element.at_css(Selector.fullHD))
    }

    private func episodeNumber(from string: String?) -> Int? {
        guard let string = string else { return nil }
        let pattern = "\\d*"
        guard let number = pattern.r?.findFirst(in: string)?.group(at: 0) else { return nil }
        return Int(number)
    }
}

extension Array where Element == Episode {
    init(from doc: HTMLDocument) {
        self.init()
        doc.css(".rls-info-container").forEach { element in
            self.append(Episode(from: element))
        }
    }
}

struct DownloadInfo {
    private enum Selector: String {
        case magnet = ".hs-magnet-link > a"
        case torrent = ".hs-torrent-link > a"
    }

    var magnet: String?
    var torrent: String?

    init?(from element: Kanna.XMLElement?) {
        guard let element = element else { return nil }
        self.magnet = element.at_css(Selector.magnet)?["href"]
        self.torrent = element.at_css(Selector.torrent)?["href"]
    }
}
