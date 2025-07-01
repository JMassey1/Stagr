import SwiftUI

struct FestivalDetailView: View {
  let festival: Festival

  var body: some View {
    Text("Festival Detail for \(festival.name)")
      .navigationTitle(festival.name)
      .navigationBarTitleDisplayMode(.inline)
  }
}
