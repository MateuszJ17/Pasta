//
//  PastaApp.swift
//  Pasta
//
//  Created by Mateusz Jaroszewski on 26/06/2022.
//

import SwiftUI

@main
struct PastaApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ClipboardItemsViewModel())
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    private var viewModel: ClipboardItemsViewModel!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        self.viewModel = ClipboardItemsViewModel()
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "tray.fill", accessibilityDescription: "Tray")
            statusButton.action = #selector(togglePopover)
        }
        
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 300, height: 500)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: ContentView(viewModel: self.viewModel))
    }
    
    @objc func togglePopover() {
        if let statusBarButton = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
            }
        }
    }
}
