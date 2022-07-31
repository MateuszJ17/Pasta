import SwiftUI

struct RowView: View {
    @StateObject private var viewModel: ClipboardItemsViewModel
    @State private var isHovering: Bool = false
    
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
            .padding(.all, 5)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            .background(isHovering ? Color.accentColor : Color.clear)
            .onHover { hover in
                isHovering = hover
            }
            Spacer()
            
            Button(action: { viewModel.deleteStoredItem(itemId: clipboardItem.id) }) {
                Label("", systemImage: "trash")
            }
            .buttonStyle(.plain)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(viewModel: ClipboardItemsViewModel(),
                clipboardItem: ClipboardItem(id: UUID()))
    }
}
