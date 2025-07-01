import Foundation
@testable import Stagr
import Testing

@Suite("Show Model Tests")
struct ShowModelTests {
  let testHelper: TestHelper

  init() throws {
    testHelper = try TestHelper()
  }

  // MARK: - ShowPriority Tests

  @Suite("ShowPriority Tests")
  struct ShowPriorityTests {
    @Test("ShowPriority raw values are correct")
    func rawValues() {
      #expect(ShowPriority.mustSee.rawValue == "Must See")
      #expect(ShowPriority.interested.rawValue == "Interested")
    }

    @Test("ShowPriority colors are correct")
    func colors() {
      #expect(ShowPriority.mustSee.color == "red")
      #expect(ShowPriority.interested.color == "blue")
    }

    @Test("ShowPriority icons are correct")
    func icons() {
      #expect(ShowPriority.mustSee.icon == "star.fill")
      #expect(ShowPriority.interested.icon == "star")
    }

    @Test("ShowPriority case iterable works correctly")
    func caseIterable() {
      let allCases = ShowPriority.allCases
      #expect(allCases.count == 2)
      #expect(allCases.contains(.mustSee))
      #expect(allCases.contains(.interested))
    }

    @Test("ShowPriority is codable")
    func codable() throws {
      let mustSee = ShowPriority.mustSee
      let interested = ShowPriority.interested

      let encoder = JSONEncoder()
      let mustSeeData = try encoder.encode(mustSee)
      let interestedData = try encoder.encode(interested)

      let decoder = JSONDecoder()
      let decodedMustSee = try decoder.decode(ShowPriority.self, from: mustSeeData)
      let decodedInterested = try decoder.decode(ShowPriority.self, from: interestedData)

      #expect(decodedMustSee == mustSee)
      #expect(decodedInterested == interested)
    }
  }

  // MARK: - Show Model Tests

  @Suite("Show Model Tests")
  struct ShowTests {
    let testHelper: TestHelper

    init() throws {
      testHelper = try TestHelper()
    }

    @Test("Show initializes with all parameters")
    func initialize() {
      let id = UUID()
      let festival = testHelper.getTestFestivals(1)[0]
      let timePair = testHelper.getDatePair(gap: 4, gapUnit: .hour)

      let show = Show(
        id: id,
        festival: festival,
        artist: "Test Artist",
        stage: "Test Stage",
        notes: "Test Notes",
        priority: .mustSee,
        startTime: timePair.start,
        endTime: timePair.end,
      )

      #expect(show.id == id)
      #expect(show.festival == festival)
      #expect(show.artist == "Test Artist")
      #expect(show.stage == "Test Stage")
      #expect(show.notes == "Test Notes")
      #expect(show.priority == .mustSee)
      #expect(show.startTime == timePair.start)
      #expect(show.endTime == timePair.end)
    }

    @Test("Show initializes correctly with default paramters")
    func initializeWithDefaults() {
      let id = UUID()
      let timePair = testHelper.getDatePair(gap: 4, gapUnit: .hour)
      let show = Show(
        id: id,
        artist: "Test Artist",
        stage: "Test Stage",
        notes: "",
        priority: .interested,
        startTime: timePair.start,
        endTime: timePair.end,
      )

      #expect(show.notes.isEmpty)
      #expect(show.priority == .interested)
    }

    @Test("Duration calculation works correctly", arguments: [
      (3600.0, "1 hour"),
      (1800.0, "30 minutes"),
      (9000.0, "2.5 hours"),
      (0.0, "0 duration")
    ])
    func durationCalculation(duration: TimeInterval, description: String) {
      let startTime = Date()
      let endTime = startTime.addingTimeInterval(duration)

      let show = Show(
        id: UUID(),
        artist: "Test Artist",
        stage: "Test Stage",
        notes: "",
        priority: .interested,
        startTime: startTime,
        endTime: endTime,
      )

      #expect(abs(show.duration - duration) < 0.1, "Duration should be \(duration) for \(description)")
    }

    @Test("Formatted duration displays correctly", arguments: [
      (3660.0, "1h 1m"), // 1 hour 1 minute
      (1800.0, "30m"), // 30 minutes
      (7200.0, "2h 0m"), // 2 hours
      (0.0, "0m") // 0 duration
    ])
    func formattedDuration(duration: TimeInterval, expected: String) {
      let startTime = Date()
      let endTime = startTime.addingTimeInterval(duration)

      let show = Show(
        id: UUID(),
        artist: "Test Artist",
        stage: "Test Stage",
        notes: "",
        priority: .interested,
        startTime: startTime,
        endTime: endTime,
      )

      #expect(show.formattedDuration == expected)
    }

    @Test("Formatted time range displays AM/PM", arguments: [
      (1, 2, "1:00 AM - 2:00 AM"),
      (12, 13, "12:00 PM - 1:00 PM"),
      (0, 13, "12:00 AM - 1:00 PM"),
      (13, 25, "1:00 PM - 1:00 AM")
    ])
    func formattedTimeRangeDisplaysAMPM(startHours: Int, endHours: Int, expected: String) {
      let startTime = Date.MidnightToday.addHours(startHours)
      let endTime = Date.MidnightToday.addHours(endHours)
      let show = Show(
        id: UUID(),
        artist: "Test Artist",
        stage: "Test Stage",
        notes: "",
        priority: .mustSee,
        startTime: startTime,
        endTime: endTime,
      )

      #expect(show.formattedTimeRange == expected)
    }
  }
}
