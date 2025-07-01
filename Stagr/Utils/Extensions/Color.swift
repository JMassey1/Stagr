import Foundation
import SwiftUI

extension Color {
  static var randomPastel: Color {
    Color(red: .random(in: 0.5...0.9), green: .random(in: 0.5...0.9), blue: .random(in: 0.5...0.9))
  }
}
