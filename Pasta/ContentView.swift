//
//  ContentView.swift
//  Pasta
//
//  Created by Mateusz Jaroszewski on 26/06/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ClipboardItemsViewModel
    
    init(viewModel: ClipboardItemsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            List(viewModel.clipboardItems, id: \.id) { clipboardItem in
                HStack {
                    VStack(alignment: .leading) {
                        Text(clipboardItem.content)
                        Divider()
                    }
                    
                    Spacer()
                }
            }
        }
        .frame(width: 300, height: 500)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ClipboardItemsViewModel())
    }
}
