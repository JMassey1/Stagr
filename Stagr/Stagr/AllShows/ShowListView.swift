import SwiftUI

struct ShowListView: View {
  @ObservedObject var viewModel: AllShowsViewModel
  
  var shows: [Show]
  
  init(viewModel: AllShowsViewModel, shows: [Show]? = nil) {
    self.viewModel = viewModel
    self.shows = shows ?? viewModel.shows
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.shows.indices, id: \.self) { index in
          let showBinding = $viewModel.shows[index]
          let show = viewModel.shows[index]
          
          NavigationLink(destination: ShowDetailView(show: showBinding)) {
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
      }
      .navigationTitle("All Shows")
    }
  }
}

#Preview {
  let viewModel = AllShowsViewModel()
  ShowListView(viewModel: viewModel)
}
