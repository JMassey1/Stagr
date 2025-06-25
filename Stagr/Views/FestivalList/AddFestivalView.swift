import SwiftUI

struct AddFestivalView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext
  
  @State var festival: Festival = Festival(
    id: UUID(),
    name: "",
    startDate: Date(),
    endDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()
  )
  
  let onSave: (() -> Void)?
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Festival Name", text: $festival.name)
            .textContentType(.name)
        }
        
        Section("Dates") {
          DatePicker("Start Date", selection: $festival.startDate, displayedComponents: [.date])
          DatePicker("End Date", selection: $festival.endDate, displayedComponents: [.date])
        }
      }
      .navigationTitle("Add Festival")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button("Cancel") {
            dismiss()
          }
        }
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add") {
            modelContext.insert(festival)
            onSave?()
            dismiss()
          }
          .disabled(festival.name.isEmpty)
        }
      }
    }
  }
}
