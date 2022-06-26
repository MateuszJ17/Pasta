//
//  ClipboardItemsViewModel.swift
//  Pasta
//
//  Created by Mateusz Jaroszewski on 26/06/2022.
//

import Foundation

class ClipboardItemsViewModel: ObservableObject {
    @Published var clipboardItems: [ClipboardItem] = []
    
    init() {
        getSampleData()
    }
    
    // TODO: create addItem func
    
    // TODO: create removeItem func
    
    func getSampleData() -> Void {
        let mockData: [ClipboardItem] = [
            ClipboardItem(id: UUID(), content: "Some test string that I pasted but not really"),
            ClipboardItem(id: UUID(), content: "Another test string"),
            ClipboardItem(id: UUID(), content: "Some really long and repeating text really long and repeating text really long and repeating text really long and repeating text")
        ]
        
        clipboardItems.append(contentsOf: mockData)
    }
}
