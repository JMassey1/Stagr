import Foundation
@testable import Stagr
import SwiftData
import Testing

@Suite("Festival Model Tests")
struct FestivalModelTests {
  let testHelper: TestHelper

  init() throws {
    testHelper = try TestHelper()
  }

  @Test("Festival Duration Calculation")
  func festivalDurationCalculation() throws {
    let datePair = testHelper.getDatePair(gap: 3)

    let festival = Festival(
      id: UUID(),
      name: "Test Festival",
      startDate: datePair.start,
      endDate: datePair.end,
    )
    #expect(festival.duration == 3)
  }

  @Test("Festival is Happening")
  func festivalIsHappening() throws {
    let datePair = testHelper.getDatePair(startDate: Date().addDays(-1), gap: 3)
    let festival = Festival(
      id: UUID(),
      name: "Test Festival",
      startDate: datePair.start,
      endDate: datePair.end,
    )
    #expect(festival.isHappening == true)
  }

  @Test("Festival is not Happening")
  func festivalIsNotHappening() throws {
    let datePair = testHelper.getDatePair(startDate: Date().addDays(1), gap: 3)
    let festival = Festival(
      id: UUID(),
      name: "Test Festival",
      startDate: datePair.start,
      endDate: datePair.end,
    )
    #expect(festival.isHappening == false)
  }

  @Test("Festival Days from Now Calculation")
  func festivalDaysFromNowCalculation() throws {
    let datePair = testHelper.getDatePair(startDate: Date().addDays(1), gap: 3)
    let festival = Festival(
      id: UUID(),
      name: "Test Festival",
      startDate: datePair.start,
      endDate: datePair.end,
    )
    #expect(festival.daysFromNow == 1)
  }
}
