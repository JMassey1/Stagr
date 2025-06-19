import Foundation

struct Show: Identifiable, Equatable {
  let id: UUID
  let artist: String
  let stage: String
  let day: String
  let time: String
  var isInterested: Bool = false
}
