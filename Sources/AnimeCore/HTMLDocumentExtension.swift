//
//  HTMLDocumentExtension.swift
//  AnimeCore
//
//  Created by Alexandre Mantovani Tavares on 25/12/18.
//

import Foundation
import Kanna

extension Searchable {
    public func at_css<Selector: RawRepresentable>(_ selector: Selector) -> Kanna.XMLElement? {
        guard let value = selector.rawValue as? String else { return nil }
        return self.at_css(value)
    }
}
