import Foundation
import SwiftData

@Model
final class Festival {
  @Attribute(.unique)
  var id: UUID
  var name: String
  @Relationship(deleteRule: .cascade)
  var shows: [Show] = []

  var createdAt = Date()
  var startDate: Date
  var endDate: Date
  var duration: Int {
    Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
  }

  var isHappening: Bool {
    let now = Date()
    return now >= startDate && now <= endDate
  }

  var daysFromNow: Int {
    let today = Calendar.current.startOfDay(for: Date())
    let start = Calendar.current.startOfDay(for: startDate)

    return Calendar.current.dateComponents([.day], from: today, to: start).day ?? 0
  }

  init(id: UUID, name: String, shows: [Show] = [], startDate: Date, endDate: Date) {
    self.id = id
    self.name = name
    self.shows = shows
    self.startDate = startDate
    self.endDate = endDate
    createdAt = Date()
  }
}
