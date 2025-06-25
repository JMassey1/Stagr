import XCTest
import SwiftData
@testable import Stagr

final class FestivalTest: XCTestCase, FestivalTestProtocol {
  var modelContainer: ModelContainer!
  var modelContext: ModelContext!
  
  override func setUp() {
    super.setUp()
    setupFestivalTest()
    addSampleFestivals()
  }
  
  override func tearDown() {
    tearDownFestivalTest()
    super.tearDown()
  }
  
  func testFestivalDurationCalculation() {
    let startDate = Date()
    let endDate = Calendar.current.date(byAdding: .day, value: 3, to: startDate)!
    
    let festival = Festival(
      id: UUID(),
      name: "Test Festival",
      startDate: startDate,
      endDate: endDate
    )
    
    XCTAssertEqual(festival.duration, 3)
  }
  
  func testFestivalIsHappening() {
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    let festival = Festival(
      id: UUID(),
      name: "Test Festival",
      startDate: yesterday,
      endDate: tomorrow
    )
    
    XCTAssertTrue(festival.isHappening)
  }
  
  func testFestivalIsNotHappening() {
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    let dayAfterTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: tomorrow)!
    
    let festival = Festival(
      id: UUID(),
      name: "Test Festival",
      startDate: tomorrow,
      endDate: dayAfterTomorrow
    )
    
    XCTAssertFalse(festival.isHappening)
  }
  
  func testFestivalDaysFromNow() {
    let futureDate = Calendar.current.date(byAdding: .day, value: 3, to: Date())!
    let endDate = Calendar.current.date(byAdding: .day, value: 3, to: futureDate)!
    
    let festival = Festival(
      id: UUID(),
      name: "Test Festival",
      startDate: futureDate,
      endDate: endDate
    )
    
    XCTAssertEqual(festival.daysFromNow, 3)
  }
}
