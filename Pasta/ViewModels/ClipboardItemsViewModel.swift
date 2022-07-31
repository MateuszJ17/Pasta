import Foundation
import AppKit
import SwiftUI

class ClipboardItemsViewModel: ObservableObject {
    @Published var clipboardItems: [ClipboardItem] = []
    private let pasteboard: NSPasteboard = .general
    
    func handleNewClipboardElement() -> Void {
        let pasteboardString = pasteboard.data(forType: .string)
        if let unwrappedPasteboardString = pasteboardString {
            let pasteboardStringContent = String(decoding: unwrappedPasteboardString, as: UTF8.self)
            
            if !isElementAlreadyCopied(element: pasteboardStringContent) {
                clipboardItems.appendOrReplaceOldest(ClipboardItem(id: UUID(), stringContent: pasteboardStringContent))
            }
        }
        
        let pasteboardImage = pasteboard.data(forType: .tiff)
        if let unwrappedPasteboardImage = pasteboardImage {
            let pasteboardNsImage = NSImage(data: unwrappedPasteboardImage)
            
            if !isElementAlreadyCopied(element: pasteboardNsImage) {
                clipboardItems.appendOrReplaceOldest(ClipboardItem(id: UUID(), imageContent: pasteboardNsImage))
            }
        }
    }
    
    func copyItemToSystemPasteboard(item: ClipboardItem) -> Void {
        pasteboard.clearContents()
        
        if let stringToInsert = item.stringContent {
            pasteboard.setString((stringToInsert), forType: .string)
        }
        if let imageToInsertTiffRepresentation = item.imageContent?.tiffRepresentation {
            pasteboard.setData(Data(imageToInsertTiffRepresentation), forType: .tiff)
        }
    }
    
    func deleteStoredItem(itemId: UUID) -> Void {
        clipboardItems.removeAll(where: { $0.id == itemId })
    }
    
    func clearAllStoredItems() -> Void {
        clipboardItems.removeAll()
    }
    
    func closePopover() -> Void {
        NSApp.sendAction(#selector(NSPopover.performClose(_:)), to: nil, from: nil)
    }
    
    private func isElementAlreadyCopied<T>(element: T) -> Bool {
        switch element {
        case let stringElement as String:
            return clipboardItems.contains(where: { $0.stringContent == stringElement })
        case let imageElement as NSImage:
            return clipboardItems.contains(where: { $0.imageContent?.tiffRepresentation == imageElement.tiffRepresentation })
        default:
            return false
        }
    }
}
