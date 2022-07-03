//
//  ClipboardItem.swift
//  Pasta
//
//  Created by Mateusz Jaroszewski on 26/06/2022.
//

import Foundation
import SwiftUI

struct ClipboardItem {
    var id: UUID
    var stringContent: String?
    var imageContent: NSImage?
}
