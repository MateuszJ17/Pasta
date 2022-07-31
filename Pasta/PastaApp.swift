import SwiftUI

@main
struct PastaApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: appDelegate.viewModel)
        }
    }
}

// TODO: maybe move popover stuff to MenuBarExtra when it comes out of beta
class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    private var timer: Timer!
    private let pasteboard: NSPasteboard = .general
    private var pasteboardLastChangeCount: Int = 0
    
    var viewModel: ClipboardItemsViewModel = ClipboardItemsViewModel()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "tray.fill", accessibilityDescription: "Tray")
            statusButton.action = #selector(togglePopover)
        }
        
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 300, height: 500)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: ContentView(viewModel: self.viewModel))
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { t in
            if self.pasteboardLastChangeCount != self.pasteboard.changeCount {
                self.pasteboardLastChangeCount = self.pasteboard.changeCount
                NotificationCenter.default.post(name: .NSPasteboardDidChange, object: self.pasteboard)
            }
        }
        
        pasteboard.prepareForNewContents()
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        self.timer.invalidate()
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
