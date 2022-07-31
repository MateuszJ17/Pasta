import Foundation
import SwiftUI

struct ClipboardItem {
    var id: UUID
    var stringContent: String?
    var imageContent: NSImage?
}

extension Array where Element == ClipboardItem {
    mutating func appendOrReplaceOldest(_ newElement: ClipboardItem) -> Void {
        if self.count < 10 {
            self.append(newElement)
            return
        }
        
        self.removeFirst()
        self.append(newElement)
    }
}
