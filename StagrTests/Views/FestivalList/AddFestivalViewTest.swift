import Foundation
import Testing
import SwiftData
@testable import Stagr

@Suite("AddFestivalView Tests")
struct AddFestivalViewTest {
  let testHelper: FestivalTestHelper
  
  init() throws {
    testHelper = try FestivalTestHelper()
  }
  
  @Test("Adding Festival")
  func AddingFestival() throws {
    let festival = Festival(
      id: UUID(),
      name: "Test Festival",
      startDate: Date(),
      endDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()
    )
    testHelper.modelContext.insert(festival)
    
    let fetchDescriptor = FetchDescriptor<Festival>()
    
    let festivals = try testHelper.modelContext.fetch(fetchDescriptor)
    #expect(festivals.count == 1)
    #expect(festivals[0] == festival)
  }
}
