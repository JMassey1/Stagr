import SwiftUI

struct AddFestivalView: View {
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    NavigationStack {
      Text("Add Festival Form")
        .navigationTitle("Add Festival")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Button("Cancel") {
              dismiss()
            }
          }
        }
    }
  }
}
