import SwiftUI

struct FooterButtonsView: View {
    @StateObject private var viewModel: ClipboardItemsViewModel
    
    init(viewModel: ClipboardItemsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        HStack {
            Button("Quit", role: .destructive) {
                NSApplication.shared.terminate(nil)
            }
            .foregroundColor(Color.red)
            Spacer()
            Button("Clear") {
                viewModel.clearAllStoredItems()
            }
        }
        .padding()
    }
}

struct FooterButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        FooterButtonsView(viewModel: ClipboardItemsViewModel())
    }
}
