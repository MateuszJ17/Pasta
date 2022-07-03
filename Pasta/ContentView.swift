//
//  ContentView.swift
//  Pasta
//
//  Created by Mateusz Jaroszewski on 26/06/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ClipboardItemsViewModel
    
    
    let pasteboardPublisher = NotificationCenter.default.publisher(for: .NSPasteboardDidChange)
    
    init(viewModel: ClipboardItemsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.clipboardItems, id: \.id) { clipboardItem in
                    RowView(viewModel: viewModel, clipboardItem: clipboardItem)
                    Divider()
                }
                .environment(\.defaultMinListRowHeight, 50)
                
                HStack {
                    Button("Quit", role: .destructive) {
                        NSApplication.shared.terminate(nil)
                    }
                    .foregroundColor(Color.red)
                    Spacer()
                }
                .padding()
            }
            .onReceive(pasteboardPublisher) { publisherOutput in
                viewModel.handleNewClipboardElement()
            }
        .frame(width: 300, height: 500)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ClipboardItemsViewModel())
    }
}
