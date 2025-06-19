import SwiftUI

@main
struct StagrApp: App {
    @StateObject private var viewModel = AllShowsViewModel()
  
    var body: some Scene {
        WindowGroup {
          TabView {
            NavigationView {
              ShowListView(viewModel: viewModel)
                .navigationTitle("All Shows")
            }
            .tabItem {
              Label("All Shows", systemImage: "list.bullet")
            }
            
            NavigationView {
              ShowListView(viewModel: viewModel, shows: viewModel.interestedShows)
                .navigationTitle("My Shows")
            }
            .tabItem {
              Label("My Shows", systemImage: "star.fill")
            }
          }
        }
    }
}
