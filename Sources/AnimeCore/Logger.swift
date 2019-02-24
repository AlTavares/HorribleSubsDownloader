//
//  Logger.swift
//  AnimeCore
//
//  Created by Alexandre Mantovani Tavares on 25/12/18.
//

import Foundation
import SwiftyBeaver

let log: SwiftyBeaver.Type = {
    let log = SwiftyBeaver.self
    let console = ConsoleDestination()
//    console.format = "$J"
    log.addDestination(console)
    let file = FileDestination()
    file.logFileURL = URL(fileURLWithPath: "logs.log")
    file.format = "$C$L$c: $M"
    log.addDestination(file)
    return log
}()
