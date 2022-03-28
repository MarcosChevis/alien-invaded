//
//  AppDelegate.swift
//  AvianInvaded macOS
//
//  Created by Marcos Chevis on 03/03/22.
//

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var window: NSWindow?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 270),
            styleMask: [.miniaturizable, .closable, .resizable, .titled],
            backing: .buffered, defer: false)
        self.window?.center()
        self.window?.title = "No Storyboard Window"
        self.window?.contentViewController = GameViewController()
        self.window?.makeKeyAndOrderFront(nil)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
}
