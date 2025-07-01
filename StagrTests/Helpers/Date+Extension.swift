import Foundation

extension Date {
  static let MidnightToday: Date = Calendar.current.startOfDay(for: Date())

  func addDays(_ days: Int) -> Date {
    // swiftlint:disable:next force_unwrapping
    Calendar.current.date(byAdding: .day, value: days, to: self)!
  }

  func addHours(_ hours: Int) -> Date {
    // swiftlint:disable:next force_unwrapping
    Calendar.current.date(byAdding: .hour, value: hours, to: self)!
  }
}
