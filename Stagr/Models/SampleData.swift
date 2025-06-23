import Foundation

extension Festival {
    static var sampleData: [Festival] {
        [
            Festival(
                id: UUID(),
                name: "Coachella",
                startDate: Calendar.current.date(byAdding: .day, value: 30, to: Date()) ?? Date(),
                endDate: Calendar.current.date(byAdding: .day, value: 32, to: Date()) ?? Date()
            ),
            Festival(
                id: UUID(),
                name: "Bonnaroo",
                startDate: Calendar.current.date(byAdding: .day, value: 60, to: Date()) ?? Date(),
                endDate: Calendar.current.date(byAdding: .day, value: 63, to: Date()) ?? Date()
            )
        ]
    }
}

extension Show {
    static func sampleShows(for festival: Festival) -> [Show] {
        [
            Show(
                id: UUID(),
                artist: "Headliner Act",
                stage: "Main Stage",
                notes: "Don't miss this one!",
                priority: ShowPriority.mustSee,
                startTime: Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: festival.startDate) ?? festival.startDate,
                endTime: Calendar.current.date(bySettingHour: 23, minute: 30, second: 0, of: festival.startDate) ?? festival.startDate
            ),
            Show(
                id: UUID(),
                artist: "Indie Band",
                stage: "Sahara Tent",
                notes: "Check them out if possible",
                priority: ShowPriority.interested,
                startTime: Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: festival.startDate) ?? festival.startDate,
                endTime: Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: festival.startDate) ?? festival.startDate
            )
        ]
    }
}
