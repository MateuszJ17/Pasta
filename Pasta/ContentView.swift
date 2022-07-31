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
                if viewModel.clipboardItems.count == 0 {
                    VStack {
                        Spacer()
                        Text("Start by copying some items into clipboard")
                            .foregroundColor(.secondary)
                        Spacer()
                        FooterButtonsView(viewModel: viewModel)
                    }
                }
                else {
                    List(viewModel.clipboardItems.reversed(), id: \.id) { clipboardItem in
                        RowView(viewModel: viewModel, clipboardItem: clipboardItem)
                            .onTapGesture {
                                viewModel.copyItemToSystemPasteboard(item: clipboardItem)
                                viewModel.closePopover() // TODO: make method to copy item to clipboard and call it here
                            }
                        Divider()
                    }
                    .environment(\.defaultMinListRowHeight, 50)
                    
                    FooterButtonsView(viewModel: viewModel)
                }
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
