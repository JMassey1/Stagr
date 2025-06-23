import SwiftUI
import SwiftData

@main
struct StagrApp: App {
  
    var body: some Scene {
        WindowGroup {
          FestivalListView()
        }
        .modelContainer(for: [Festival.self, Show.self]) { val in
            print(val)
        }
    }
}
