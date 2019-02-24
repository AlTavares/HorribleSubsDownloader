//
//  Constants.swift
//  anime
//
//  Created by Alexandre Mantovani Tavares on 23/12/18.
//

import Foundation

enum Constants {
    static var config = ConfigurationService().getConfiguration()
    enum Files {
        static let showPath = URL(string: "Config/Shows")!
        static let config = URL(string: "Config/config.json")!
    }
}
