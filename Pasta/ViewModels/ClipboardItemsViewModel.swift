//
//  ClipboardItemsViewModel.swift
//  Pasta
//
//  Created by Mateusz Jaroszewski on 26/06/2022.
//

import Foundation
import AppKit
import SwiftUI

class ClipboardItemsViewModel: ObservableObject {
    @Published var clipboardItems: [ClipboardItem] = []
    let pasteboard: NSPasteboard = .general
    
    init() {
        //        pasteboard.prepareForNewContents()
        getSampleData()
    }
    
    // TODO: create removeItem func
    
    func getSampleData() -> Void {
        let mockData: [ClipboardItem] = [
            ClipboardItem(id: UUID(), stringContent: "Some test string that I pasted but not really"),
            ClipboardItem(id: UUID(), stringContent: "Another test string"),
            ClipboardItem(id: UUID(), stringContent: "Some really long and repeating text really long and repeating text really long and repeating text really long and repeating text")
        ]
        
        clipboardItems.append(contentsOf: mockData)
    }
    
    func handleNewClipboardElement() -> Void {
        let pasteboardString = pasteboard.data(forType: .string)
        if let unwrappedPasteboardString = pasteboardString {
            let pasteboardStringContent = String(decoding: unwrappedPasteboardString, as: UTF8.self)
            
            if !isElementAlreadyCopied(pasteboardStringContent) {
                clipboardItems.appendOrReplaceOldest(ClipboardItem(id: UUID(), stringContent: pasteboardStringContent))
            }
        }
        
        let pasteboardImage = pasteboard.data(forType: .tiff)
        if let unwrappedPasteboardImage = pasteboardImage {
            let pasteboardNsImage = NSImage(data: unwrappedPasteboardImage)
            
            if !isElementAlreadyCopied(pasteboardNsImage) {
                clipboardItems.appendOrReplaceOldest(ClipboardItem(id: UUID(), imageContent: pasteboardNsImage))
            }
        }
    }
    
    
    func isElementAlreadyCopied<T>(_ element: T) -> Bool {
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
