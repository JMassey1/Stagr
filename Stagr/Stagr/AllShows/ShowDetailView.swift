import SwiftUI

struct ShowDetailView: View {
  private let VERTICAL_SPACING: CGFloat = 16
  private let BUTTON_CORNER_RADIUS: CGFloat = 10
  
  @ObservedObject var viewModel: AllShowsViewModel
  let show: Show
  
  var body: some View {
    VStack(spacing: VERTICAL_SPACING) {
      Text(show.artist)
        .font(.largeTitle)
        .bold()
      
      Text(show.stage)
        .font(.title2)
      
      Text("\(show.day), \(show.time)")
        .font(.subheadline)
        .foregroundColor(.gray)
      
      Button(action: {
        viewModel.toggleInterested(for: show)
      }) {
        Label(
          show.isInterested ? "Remove from My Shows" : "Add to My Shows",
          systemImage: show.isInterested ? "star.slash" : "star"
        )
        .padding()
        .frame(maxWidth: .infinity)
        .background(show.isInterested ? Color.red.opacity(0.1) : Color.yellow.opacity(0.1))
        .cornerRadius(BUTTON_CORNER_RADIUS)
      }
      
      Spacer()
    }
    .padding()
    .navigationTitle("Show Details")
  }
}

#Preview {
  let viewModel = AllShowsViewModel()
  return NavigationView {
    ShowDetailView(viewModel: viewModel, show: viewModel.shows.first!)
  }
}
