import SwiftUI
import SwiftData

struct FestivalListView: View {
  @Environment(\.modelContext) private var modelContext
  
  @State private var festivals: [Festival] = []
  @State private var sortBy: SortOption = .startDate
  @State private var sortOrder: SortOrder = .ascending
  @State private var showingAddFestival = false
  
  enum SortOption: String, CaseIterable {
    case startDate = "Start Date"
    case createdAt = "Created At"
  }
  
  enum SortOrder: String, CaseIterable {
    case ascending = "Ascending"
    case descending = "Descending"
    
    var systemImage: String {
      switch self {
      case .ascending: return "arrow.up"
      case .descending: return "arrow.down"
      }
    }
  }
  
  var body: some View {
    NavigationStack() {
      ZStack {
        LinearGradient(colors: [Color(.systemBackground), Color(.systemGray6)], startPoint: .top, endPoint: .bottom)
          .ignoresSafeArea()
        
        if festivals.isEmpty {
          emptyStateView
        } else {
          festivalsList
        }
      }
      // TODO: Make My Festivals not move with navigation scroll
      .navigationTitle("My Festivals")
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          HStack(spacing: 8) {
            Menu {
              ForEach(SortOption.allCases, id: \.self) { option in
                Button(action: { setSortBy(option) }) {
                  Label(option.rawValue, systemImage: sortBy == option ? "checkmark.circle" : "circle")
                }
              }
            } label: {
              Image(systemName: "line.3.horizontal.decrease.circle")
            }
            
            Button(action: toggleSortOrder) {
              Image(systemName: sortOrder.systemImage)
            }
          }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            showingAddFestival = true
          } label: {
            Image(systemName: "plus.circle.fill")
              .font(.title2)
              .foregroundStyle(.tint)
          }
        }
      }
      .sheet(isPresented: $showingAddFestival) {
        AddFestivalView(onSave: loadFestivals)
      }
      .task {
        loadFestivals()
        addSampleDataIfNeeded()
      }
    }
  }
  
  private var festivalsList: some View {
    List {
      ForEach(festivals) { festival in
        NavigationLink {
          FestivalDetailView(festival: festival)
        } label: {
          FestivalCard(festival: festival)
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .listRowSeparator(.hidden)
      }
      .onDelete(perform: deleteFestival)
    }
    .listStyle(.plain)
    .scrollContentBackground(.hidden)
  }
  
  private var emptyStateView: some View {
    VStack(spacing: 24) {
      Image(systemName: "music.note.house.fill")
        .font(.system(size: 64))
        .foregroundStyle(.secondary)
      
      VStack(spacing: 8) {
        Text("No Festivals Yet...")
          .font(.title2).fontWeight(.semibold)
        
        Text("Add your first festival to get started!")
          .font(.body)
          .foregroundStyle(.secondary)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 32)
      }
      
      Button {
        showingAddFestival = true
      } label: {
        HStack {
          Image(systemName: "plus")
          Text("Add Festival")
        }
        .font(.headline)
        .foregroundStyle(.white)
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(Color.accentColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
      }
    }
  }
  
  private func addSampleDataIfNeeded() {
    guard festivals.isEmpty else { return }
    
    let sampleFestivals = Festival.sampleData
    for festival in sampleFestivals {
      modelContext.insert(festival)
      
      let sampleShows = Show.sampleShows(for: festival)
      for show in sampleShows {
        show.festival = festival
        modelContext.insert(show)
      }
    }
  }
  
  private func loadFestivals() {
    let sortDescriptor: SortDescriptor<Festival>
    
    switch sortBy {
    case .startDate:
      sortDescriptor = SortDescriptor(\Festival.startDate, order: sortOrder == .ascending ? .forward : .reverse)
    case .createdAt:
      sortDescriptor = SortDescriptor(\Festival.createdAt, order: sortOrder == .ascending ? .forward : .reverse)
    }
    
    let descriptor = FetchDescriptor<Festival>(sortBy: [sortDescriptor])
    do {
      festivals = try modelContext.fetch(descriptor)
    } catch {
      print("Failed to fetch festivals: \(error)")
    }
  }
  
  private func setSortBy(_ sortBy: SortOption) {
    self.sortBy = sortBy
    loadFestivals()
  }
  
  private func toggleSortOrder() {
    sortOrder = sortOrder == .ascending ? .descending : .ascending
    loadFestivals()
  }
  
  private func deleteFestival(at offsets: IndexSet) {
    for index in offsets {
      modelContext.delete(festivals[index])
    }
    loadFestivals()
  }
}

#Preview {
  FestivalListView()
}

#Preview {
  // swiftlint:disable:next force_try
  let container = try! ModelContainer(
    for: Festival.self,
    configurations: ModelConfiguration(isStoredInMemoryOnly: true)
  )
  let context = container.mainContext

  for festival in Festival.sampleData {
    context.insert(festival)
  }

  return FestivalListView()
    .modelContainer(container)
}
