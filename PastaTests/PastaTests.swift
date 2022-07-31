import XCTest
@testable import Pasta

class PastaTests: XCTestCase {
    
    var clipboardItemsViewModel: ClipboardItemsViewModel!

    override func setUpWithError() throws {
        clipboardItemsViewModel = ClipboardItemsViewModel()
    }

    override func tearDownWithError() throws {
        clipboardItemsViewModel = nil
    }

    func testClipboardStringItemIsAddedWhenTheListIsNotFull() {
        // arrange
        clipboardItemsViewModel.clipboardItems = [
            ClipboardItem(id: UUID(), stringContent: "1"),
            ClipboardItem(id: UUID(), stringContent: "2"),
            ClipboardItem(id: UUID(), stringContent: "3")
        ]
        
        // act
        clipboardItemsViewModel.clipboardItems.appendOrReplaceOldest(ClipboardItem(id: UUID(), stringContent: "4"))
        
        // assert
        XCTAssertTrue(clipboardItemsViewModel.clipboardItems.contains(where: { $0.stringContent == "1" }))
        XCTAssertTrue(clipboardItemsViewModel.clipboardItems.contains(where: { $0.stringContent == "2" }))
        XCTAssertTrue(clipboardItemsViewModel.clipboardItems.contains(where: { $0.stringContent == "3" }))
        XCTAssertTrue(clipboardItemsViewModel.clipboardItems.contains(where: { $0.stringContent == "4" }))
        XCTAssertTrue(clipboardItemsViewModel.clipboardItems.count == 4)
    }
    
    func testClipboardOldestStringItemIsReplacedWhenTheListIsFull() {
        // arrange
        clipboardItemsViewModel.clipboardItems = [
            ClipboardItem(id: UUID(), stringContent: "1"),
            ClipboardItem(id: UUID(), stringContent: "2"),
            ClipboardItem(id: UUID(), stringContent: "3"),
            ClipboardItem(id: UUID(), stringContent: "4"),
            ClipboardItem(id: UUID(), stringContent: "5"),
            ClipboardItem(id: UUID(), stringContent: "6"),
            ClipboardItem(id: UUID(), stringContent: "7"),
            ClipboardItem(id: UUID(), stringContent: "8"),
            ClipboardItem(id: UUID(), stringContent: "9"),
            ClipboardItem(id: UUID(), stringContent: "10"),
        ]
        
        // act
        clipboardItemsViewModel.clipboardItems.appendOrReplaceOldest(ClipboardItem(id: UUID(), stringContent: "11"))
        
        // assert
        XCTAssertTrue(clipboardItemsViewModel.clipboardItems.contains(where: { $0.stringContent == "11" }))
        XCTAssertTrue(!clipboardItemsViewModel.clipboardItems.contains(where: { $0.stringContent == "1" }))
        XCTAssertTrue(clipboardItemsViewModel.clipboardItems.count == 10)
    }

}
