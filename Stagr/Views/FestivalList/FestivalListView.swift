import SwiftUI
import SwiftData

struct FestivalListView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \Festival.startDate) private var festivals: [Festival]
  @State private var showingAddFestival = false
  
  var body: some View {
    NavigationStack {
      ZStack {
        LinearGradient(colors: [Color(.systemBackground), Color(.systemGray6)], startPoint: .top, endPoint: .bottom)
          .ignoresSafeArea()
        
        if festivals.isEmpty {
          emptyStateView
        } else {
          festivalsList
        }
      }
      .navigationTitle("My Festivals").navigationBarTitleDisplayMode(.large)
      .toolbar {
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
        AddFestivalView()
      }
      .task {
        addSampleDataIfNeeded()
      }
//      onAppear {
//        addSampleDataIfNeeded()
//      }
    }
  }
  
  private var festivalsList: some View {
    ScrollView {
      LazyVStack(spacing: 16) {
        ForEach(festivals) { festival in
          NavigationLink {
            FestivalDetailView(festival: festival)
          } label: {
            FestivalCard(festival: festival)
          }
          .buttonStyle(PlainButtonStyle())
        }
      }
      .padding(.horizontal).padding(.top, 8)
    }
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
}
