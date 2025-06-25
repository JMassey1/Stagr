import XCTest
import SwiftData
@testable import Stagr

final class FestivalListViewTest: XCTestCase, FestivalTestProtocol {
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
  
  func testLoadingFestivals() {
    let fetchDescriptor = FetchDescriptor<Festival>()
    
    addSampleFestivals()
    do {
      let festivals = try modelContext.fetch(fetchDescriptor)
      XCTAssertEqual(festivals.count, 3)
    } catch {
      XCTFail("Failed to fetch festivals: \(error)")
    }
  }
  
  func testLoadingEmptyFestivals() {
    let fetchDescriptor = FetchDescriptor<Festival>()
    
    do {
      let festivals = try modelContext.fetch(fetchDescriptor)
      XCTAssertTrue(festivals.isEmpty)
    } catch {
      XCTFail("Failed to fetch festivals: \(error)")
    }
  }
  
  // MARK: - Sorting Tests
  func testSortingByStartDateAscending() {
    let sortDescriptor = SortDescriptor(\Festival.startDate, order: .forward)
    let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
    
    addSampleFestivals()
    
    do {
      let festivals = try modelContext.fetch(fetchDescriptor)
      XCTAssertEqual(festivals.count, 3)
      
      for i in 0..<festivals.count - 1 {
        XCTAssertLessThanOrEqual(festivals[i].startDate, festivals[i + 1].startDate)
      }
    } catch {
      XCTFail( "Failed to fetch festivals: \(error)")
    }
  }
  
  func testSortingByStartDateDescending() {
    let sortDescriptor = SortDescriptor(\Festival.startDate, order: .reverse)
    let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
    
    addSampleFestivals()
    
    do {
      let festivals = try modelContext.fetch(fetchDescriptor)
      XCTAssertEqual(festivals.count, 3)
      
      for i in 0..<festivals.count - 1 {
        XCTAssertGreaterThanOrEqual(festivals[i].startDate, festivals[i + 1].startDate)
      }
    } catch {
      XCTFail( "Failed to fetch festivals: \(error)")
    }
  }
  
  func testSortingByCreatedAtAscending() {
    let sortDescriptor = SortDescriptor(\Festival.createdAt, order: .forward)
    let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
    
    addSampleFestivals()
    
    do {
      let festivals = try modelContext.fetch(fetchDescriptor)
      XCTAssertEqual(festivals.count, 3)
      
      for i in 0..<festivals.count - 1 {
        XCTAssertLessThanOrEqual(festivals[i].startDate, festivals[i + 1].startDate)
      }
    } catch {
      XCTFail( "Failed to fetch festivals: \(error)")
    }
  }
  
  func testSortingByCreatedAtDescending() {
    let sortDescriptor = SortDescriptor(\Festival.createdAt, order: .reverse)
    let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
    
    addSampleFestivals()
    
    do {
      let festivals = try modelContext.fetch(fetchDescriptor)
      XCTAssertEqual(festivals.count, 3)
      
      for i in 0..<festivals.count - 1 {
        XCTAssertGreaterThanOrEqual(festivals[i].startDate, festivals[i + 1].startDate)
      }
    } catch {
      XCTFail( "Failed to fetch festivals: \(error)")
    }
  }
}
