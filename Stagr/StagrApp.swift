import SwiftData
import SwiftUI

@main
struct StagrApp: App {
  var body: some Scene {
    WindowGroup {
      RootView()
    }
    .modelContainer(for: [Festival.self, Show.self])
  }
}

struct RootView: View {
  var body: some View {
    FestivalListView()
  }
}
