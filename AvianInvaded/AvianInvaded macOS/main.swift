//
//  Main.swift
//  AvianInvaded macOS
//
//  Created by Marcos Chevis on 04/03/22.
//

import Foundation
import AppKit

let app: NSApplication =  {
    let app = NSApplication.shared
    let delegate = AppDelegate()
    app.delegate = delegate
    
    return app
}()

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

