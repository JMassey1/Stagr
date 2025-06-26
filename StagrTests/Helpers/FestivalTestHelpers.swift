import XCTest
import Testing
import SwiftData
@testable import Stagr

protocol FestivalTestProtocol: XCTestCase {
  var modelContainer: ModelContainer! { get set }
  var modelContext: ModelContext! { get set }
}

extension FestivalTestProtocol {
  func setupFestivalTest() {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    do {
      modelContainer = try ModelContainer(for: Festival.self, Show.self, configurations: config)
      modelContext = ModelContext(modelContainer)
    } catch {
      XCTFail("Failed to create model container: \(error)")
    }
  }
  
  func tearDownFestivalTest() {
    modelContainer = nil
    modelContext = nil
  }
  
  func addSampleFestivals() {
    let baseDate = Date()
    
    let pastFestival = Festival(
      id: UUID(),
      name: "Past Festival",
      startDate: Calendar.current.date(byAdding: .day, value: -10, to: baseDate)!,
      endDate: Calendar.current.date(byAdding: .day, value: -3, to: baseDate)!
    )
    Thread.sleep(forTimeInterval: DEFAULT_SLEEP_DURATION)
    
    let currentFestival = Festival(
      id: UUID(),
      name: "Current Festival",
      startDate: Calendar.current.date(byAdding: .day, value: -2, to: baseDate)!,
      endDate: Calendar.current.date(byAdding: .day, value: 3, to: baseDate)!
    )
    Thread.sleep(forTimeInterval: DEFAULT_SLEEP_DURATION)
    
    let futureFestival = Festival(
      id: UUID(),
      name: "Future Festival",
      startDate: Calendar.current.date(byAdding: .day, value: 3, to: baseDate)!,
      endDate: Calendar.current.date(byAdding: .day, value: 10, to: baseDate)!
    )
    Thread.sleep(forTimeInterval: DEFAULT_SLEEP_DURATION)
    
    modelContext.insert(pastFestival)
    modelContext.insert(currentFestival)
    modelContext.insert(futureFestival)
  }
}

class FestivalTestHelper {
  let modelContainer: ModelContainer
  let modelContext: ModelContext
  
  init() throws {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    modelContainer = try ModelContainer(for: Festival.self, Show.self, configurations: config)
    modelContext = ModelContext(modelContainer)
  }
  
  func addSampleFestivals() {
    let baseDate = Date()
    
    let pastFestival = Festival(
      id: UUID(),
      name: "Past Festival",
      startDate: Calendar.current.date(byAdding: .day, value: -10, to: baseDate)!,
      endDate: Calendar.current.date(byAdding: .day, value: -3, to: baseDate)!
    )
    Thread.sleep(forTimeInterval: DEFAULT_SLEEP_DURATION)
    
    let currentFestival = Festival(
      id: UUID(),
      name: "Current Festival",
      startDate: Calendar.current.date(byAdding: .day, value: -2, to: baseDate)!,
      endDate: Calendar.current.date(byAdding: .day, value: 3, to: baseDate)!
    )
    Thread.sleep(forTimeInterval: DEFAULT_SLEEP_DURATION)
    
    let futureFestival = Festival(
      id: UUID(),
      name: "Future Festival",
      startDate: Calendar.current.date(byAdding: .day, value: 3, to: baseDate)!,
      endDate: Calendar.current.date(byAdding: .day, value: 10, to: baseDate)!
    )
    Thread.sleep(forTimeInterval: DEFAULT_SLEEP_DURATION)
    
    modelContext.insert(pastFestival)
    modelContext.insert(currentFestival)
    modelContext.insert(futureFestival)
  }
  
  func getTestFestivals(_ count: Int, areUnique: Bool = false) -> [Festival] {
    var festivals: [Festival] = []
    for _ in 0..<count {
      let datePair = getDatePair(startDate: areUnique ? Date().addDays(count) : nil, gap: 3)
      
      festivals.append(Festival(
        id: UUID(),
        name: "Test Festival \(count + 1)",
        startDate: datePair.start,
        endDate: datePair.end
      ))
      }
    
    return festivals
  }
  
  func getDatePair(startDate: Date? = nil, gap: Int, gapUnit: Calendar.Component = .day) -> (start: Date, end: Date) {
    let startDate = startDate ?? Date()
    let endDate = Calendar.current.date(byAdding: gapUnit, value: gap, to: startDate)!
    return (startDate, endDate)
  }
}

extension Date {
  func addDays(_ days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: self)!
  }
}
