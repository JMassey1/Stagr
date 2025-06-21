import Foundation

extension Festival {
  static var sampleData: [Festival] {
    let coachella = Festival(
      id: UUID(),
      name: "Coachella",
      startDate: Calendar.current.date(byAdding: .day, value: 30, to: Date()) ?? Date(),
      endDate: Calendar.current.date(byAdding: .day, value: 32, to: Date()) ?? Date()
    )
    
    let bonnaroo = Festival(
      id: UUID(),
      name: "Bonnaroo",
      startDate: Calendar.current.date(byAdding: .day, value: 60, to: Date()) ?? Date(),
      endDate: Calendar.current.date(byAdding: .day, value: 63, to: Date()) ?? Date()
    )
    
    return [coachella, bonnaroo]
  }
}


extension Show {
  static func sampleShows(for festivalId: UUID) -> [Show] {
    let baseDate = Calendar.current.date(byAdding: .day, value: 30, to: Date()) ?? Date()
    
    return [
      Show(
        id: UUID(),
        artist: "Headliner Act",
        stage: "Main Stage",
        startTime: Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: baseDate) ?? baseDate,
        endTime: Calendar.current.date(bySettingHour: 23, minute: 30, second: 0, of: baseDate) ?? baseDate,
        priority: .mustSee,
        notes: "Don't miss this one!",
        festivalId: festivalId
      ),
      Show(
        id: UUID(),
        artist: "Indie Band",
        stage: "Sahara Tent",
        startTime: Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: baseDate) ?? baseDate,
        endTime: Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: baseDate) ?? baseDate,
        priority: .interested,
        notes: "Check them out if possible",
        festivalId: festivalId
      )
    ]
  }
}
