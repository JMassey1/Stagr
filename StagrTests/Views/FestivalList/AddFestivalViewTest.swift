import Foundation
import Testing
import SwiftData
@testable import Stagr

@Suite("AddFestivalView Tests")
struct AddFestivalViewTest {
  let testHelper: TestHelper

  init() throws {
    testHelper = try TestHelper()
  }

  @Test("Adding Festival")
  func addingFestival() throws {
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
