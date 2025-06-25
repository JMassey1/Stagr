import Foundation
import SwiftData

@Model
final class Festival {
  @Attribute(.unique) var id: UUID
  var name: String
  @Relationship(deleteRule: .cascade) var shows: [Show] = []
  
  var createdAt: Date = Date()
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
    Calendar.current.dateComponents([.day], from: Date(), to: startDate).day ?? 0
  }
  
  init(id: UUID, name: String, shows: [Show] = [], startDate: Date, endDate: Date) {
    self.id = id
    self.name = name
    self.shows = shows
    self.startDate = startDate
    self.endDate = endDate
    self.createdAt = Date()
  }
}
