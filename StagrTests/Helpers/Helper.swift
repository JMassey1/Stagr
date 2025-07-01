import Foundation
@testable import Stagr
import SwiftData
import Testing

class TestHelper {
  let modelContainer: ModelContainer
  let modelContext: ModelContext

  init() throws {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    modelContainer = try ModelContainer(for: Festival.self, Show.self, configurations: config)
    modelContext = ModelContext(modelContainer)
  }
}
