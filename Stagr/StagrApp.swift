import SwiftUI
import SwiftData

@main
struct StagrApp: App {
  
    var body: some Scene {
        WindowGroup {
          Image(systemName: "globe")
        }
        .modelContainer(for: [Festival.self, Show.self])
    }
}
