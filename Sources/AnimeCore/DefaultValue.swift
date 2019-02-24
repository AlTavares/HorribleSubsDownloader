//
//  Default.swift
//  AnimeCore
//
//  Created by Alexandre Mantovani Tavares on 25/12/18.
//

import Foundation

infix operator ?=

public func ?= <T>(left: inout T, right: Optional<T>) {
    guard let value = right else { return }
    left = value
}
