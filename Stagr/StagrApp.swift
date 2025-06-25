import SwiftUI
import SwiftData

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
