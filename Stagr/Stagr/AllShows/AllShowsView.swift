import SwiftUI

struct AllShowsView: View {
  @StateObject private var viewModel = AllShowsViewModel()
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.shows) { show in
          HStack {
            VStack(alignment: .leading) {
              Text(show.artist)
                .font(.headline)
              Text("\(show.stage) * \(show.day) * \(show.time)")
                .font(.subheadline)
                .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: show.isInterested ? "star.fill" : "star")
              .foregroundColor(show.isInterested ? .yellow : .gray)
              .onTapGesture {
                viewModel.toggleInterested(for: show)
              }
          }
          .padding(.vertical, 4)
        }
      }
      .navigationTitle("All Shows")
    }
  }
}
