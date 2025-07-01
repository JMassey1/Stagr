import Foundation
@testable import Stagr
import SwiftData
import Testing

@Suite("FestivalListView Tests")
struct FestivalListViewTest {
  let testHelper: TestHelper

  init() throws {
    testHelper = try TestHelper()
  }

  // MARK: - Loading Tests

  @Test("Loading Festivals")
  func loadingFestivals() throws {
    let fetchDescriptor = FetchDescriptor<Festival>()
    testHelper.addSampleFestivals()

    let festivals = try testHelper.modelContext.fetch(fetchDescriptor)
    #expect(festivals.count == 3)
  }

  @Test("Loading Empty Festivals")
  func loadingEmptyFestivals() throws {
    let fetchDescriptor = FetchDescriptor<Festival>()

    let festivals = try testHelper.modelContext.fetch(fetchDescriptor)
    #expect(festivals.isEmpty)
  }

  // MARK: - Sorting Tests

  @Test("Sorting by start date, ascending")
  func sortingByStartDateAscending() throws {
    let sortDescriptor = SortDescriptor(\Festival.startDate, order: .forward)
    let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
    testHelper.addSampleFestivals()

    let festivals = try testHelper.modelContext.fetch(fetchDescriptor)
    #expect(festivals.count == 3)

    for i in 0 ..< festivals.count - 1 {
      #expect(festivals[i].startDate <= festivals[i + 1].startDate)
    }
  }

  @Test("Sorting by start date, descending")
  func sortingByStartDateDescending() throws {
    let sortDescriptor = SortDescriptor(\Festival.startDate, order: .reverse)
    let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
    testHelper.addSampleFestivals()

    let festivals = try testHelper.modelContext.fetch(fetchDescriptor)
    #expect(festivals.count == 3)

    for i in 0 ..< festivals.count - 1 {
      #expect(festivals[i].startDate >= festivals[i + 1].startDate)
    }
  }

  @Test("Sorting by created at, ascending")
  func sortingByCreatedAtAscending() throws {
    let sortDescriptor = SortDescriptor(\Festival.createdAt, order: .forward)
    let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
    testHelper.addSampleFestivals()

    let festivals = try testHelper.modelContext.fetch(fetchDescriptor)
    #expect(festivals.count == 3)

    for i in 0 ..< festivals.count - 1 {
      #expect(festivals[i].createdAt <= festivals[i + 1].createdAt)
    }
  }

  @Test("Sorting by created at, descending")
  func sortingByCreatedAtDescending() throws {
    let sortDescriptor = SortDescriptor(\Festival.createdAt, order: .reverse)
    let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
    testHelper.addSampleFestivals()

    let festivals = try testHelper.modelContext.fetch(fetchDescriptor)
    #expect(festivals.count == 3)

    for i in 0 ..< festivals.count - 1 {
      #expect(festivals[i].createdAt >= festivals[i + 1].createdAt)
    }
  }
}
