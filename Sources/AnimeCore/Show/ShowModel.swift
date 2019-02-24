//
//  ShowModel.swift
//  anime
//
//  Created by Alexandre Mantovani Tavares on 23/12/18.
//

import Foundation
import Kanna
import Regex

struct Show {
    private enum Selector: String {
        case name = "header > h1.entry-title"
        case description = "div.series-desc p"
        case imagePath = "div.series-image > img"
    }

    var id: String = ""
    var name: String = ""
    var slug: String = ""
    var description: String = ""
    var imagePath: String = ""
    var episodes: [Episode] = []
}

extension Show {
    init(from doc: HTMLDocument, slug: String) {
        self.slug = slug
        if let text = doc.text {
            self.id ?= self.getID(from: text)
        }
        self.name ?= doc.at_css(Selector.name)?.text
        self.description ?= doc.at_css(Selector.description)?.text
        self.imagePath ?= doc.at_css(Selector.imagePath)?["src"]
    }

    private func getID(from text: String) -> String? {
        let pattern = "hs_showid.+\\s(\\d+)"
        return pattern.r?.findFirst(in: text)?.group(at: 1)
    }
}
