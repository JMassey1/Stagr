import XCTest
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
