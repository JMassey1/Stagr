import Foundation

final class AllShowsViewModel: ObservableObject {
  @Published var shows: [Show] = []
  
  init() {
    loadMockData()
  }
  
  func toggleInterested(for show: Show) {
    guard let index = shows.firstIndex(of: show) else { return }
    shows[index].isInterested.toggle()
  }
  
  private func loadMockData() {
    shows = [
      Show(id: UUID(), artist: "ODESZA", stage: "What Stage", day: "Friday", time: "22:00", isInterested: false),
      Show(id: UUID(), artist: "Fred again..", stage: "That Tent", day: "Thursday", time: "12:00", isInterested: true),
      Show(id: UUID(), artist: "2hollis", stage: "This Tent", day: "Saturday", time: "19:00", isInterested: true)
    ]
  }
}
