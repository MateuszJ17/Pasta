//
//  RowView.swift
//  Pasta
//
//  Created by Mateusz Jaroszewski on 03/07/2022.
//

import SwiftUI

struct RowView: View {
    @StateObject private var viewModel: ClipboardItemsViewModel
    
    let clipboardItem: ClipboardItem
    
    init(viewModel: ClipboardItemsViewModel, clipboardItem: ClipboardItem) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.clipboardItem = clipboardItem
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if clipboardItem.stringContent != nil {
                    Text(clipboardItem.stringContent!)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                        .frame(height: 70)
                }
                if clipboardItem.imageContent != nil {
                    Image(nsImage: clipboardItem.imageContent!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                }
            }
            Spacer()
            
            // TODO: create delete from pasteboard function and call it here
            Button(action: viewModel.getSampleData) {
                Label("", systemImage: "doc.on.doc")
            }
            .buttonStyle(.plain)
            
            // TODO: if shortcuts will be implemented display command+number
//            Text("index")
//                .foregroundStyle(.secondary)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(viewModel: ClipboardItemsViewModel(),
                clipboardItem: ClipboardItem(id: UUID()))
    }
}
