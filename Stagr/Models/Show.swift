import Foundation
import SwiftData

enum ShowPriority: String, CaseIterable, Codable {
  case mustSee = "Must See"
  case interested = "Interested"
  
  var color: String {
    switch self {
    case .mustSee:
      return "red"
    case .interested:
      return "blue"
    }
  }
  
  var icon: String {
    switch self {
    case .mustSee:
      return "star.fill"
    case .interested:
      return "star"
    }
  }
}

@Model
final class Show {
  @Attribute(.unique) var id: UUID
  var festival: Festival?
  var artist: String
  var stage: String
  var notes: String = ""
  
  var priorityRaw: String
  var priority: ShowPriority {
    get { ShowPriority(rawValue: priorityRaw) ?? .interested }
    set { priorityRaw = newValue.rawValue }
  }
  
  var startTime: Date
  var endTime: Date
  var duration: TimeInterval {
    endTime.timeIntervalSince(startTime)
  }
  var formattedDuration: String {
    let hours = Int(duration) / 3600
    let minutes = Int(duration) % 3600 / 60
    
    if hours > 0 {
      return "\(hours)h \(minutes)m"
    } else {
      return "\(minutes)m"
    }
  }
  var formattedTimeRange: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    return "\(formatter.string(from: startTime)) - \(formatter.string(from: endTime))"
  }
  
  init(id: UUID, festival: Festival? = nil, artist: String, stage: String, notes: String, priorityRaw: String, startTime: Date, endTime: Date) {
    self.id = id
    self.festival = festival
    self.artist = artist
    self.stage = stage
    self.notes = notes
    self.priorityRaw = priorityRaw
    self.startTime = startTime
    self.endTime = endTime
  }
}
