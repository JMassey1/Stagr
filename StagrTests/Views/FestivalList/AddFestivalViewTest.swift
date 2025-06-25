import XCTest
import SwiftData
@testable import Stagr

final class AddFestivalViewTest: XCTestCase, FestivalTestProtocol {
  var modelContainer: ModelContainer!
  var modelContext: ModelContext!
  
  override func setUp() {
    super.setUp()
    setupFestivalTest()
  }
  
  override func tearDown() {
    tearDownFestivalTest()
    super.tearDown()
  }
  
  func testAddingFestival() {
    let festival = Festival(
      id: UUID(),
      name: "Test Festival",
      startDate: Date(),
      endDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()
    )
    
    modelContext.insert(festival)
    
    let fetchDescriptor = FetchDescriptor<Festival>()
    do {
      let festivals = try modelContext.fetch(fetchDescriptor)
      XCTAssertEqual(festivals.count, 1)
      XCTAssertEqual(festivals.first?.name, "Test Festival")
      XCTAssertEqual(festivals.first?.id, festival.id)
    } catch {
      XCTFail("Failed to fetch festivals: \(error)")
    }
  }
}
