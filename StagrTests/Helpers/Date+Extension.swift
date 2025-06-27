import Foundation

extension Date {
  func addDays(_ days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: self)!
  }
}
