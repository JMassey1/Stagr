import SwiftUI

struct FestivalCard: View {
  let festival: Festival

  var body: some View {
    ZStack(alignment: .bottomLeading) {
      // background
      LinearGradient(
        gradient: Gradient(colors: [.clear, .randomPastel]),
        startPoint: .trailing,
        endPoint: .leading,
      )

      // foreground
      VStack(alignment: .leading, spacing: 12) {
        HStack {
          VStack(alignment: .leading, spacing: 4) {
            Text(festival.name)
              .font(.title2)
              .fontWeight(.bold)
              .foregroundStyle(.primary)

            Text(dateRangeText)
              .font(.subheadline)
              .foregroundStyle(.secondary)
          }

          Spacer()

          statusBadge
        }

        HStack(spacing: 24) {
          statItem(icon: "calendar", value: "\(festival.duration + 1)", label: "Days")
          statItem(icon: "music.note", value: "\(festival.shows.count)", label: "Shows")
          statItem(
            icon: "star.fill",
            value: "\(festival.shows.count { $0.priority == .mustSee })",
            label: "Must See",
          )
        }
      }
      .padding()
    }
    .frame(height: 125)
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
  }

  private var dateRangeText: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"

    let startText = formatter.string(from: festival.startDate)
    let endText = formatter.string(from: festival.endDate)

    let calendar = Calendar.current
    if !calendar.isDate(festival.startDate, equalTo: Date(), toGranularity: .year) {
      formatter.dateFormat = "MMM d, yyyy"
      return "\(formatter.string(from: festival.startDate)) - \(formatter.string(from: festival.endDate))"
    }

    return "\(startText) - \(endText)"
  }

  private var statusBadge: some View {
    Group {
      if festival.isHappening {
        statusBadgeView(text: "Live Now", color: .green)
      } else if festival.daysFromNow > 0 {
        statusBadgeView(text: "\(festival.daysFromNow) Days", color: .blue)
      } else {
        statusBadgeView(text: "Past", color: .gray)
      }
    }
  }

  private func statusBadgeView(text: String, color: Color) -> some View {
    Text(text)
      .font(.caption)
      .fontWeight(.semibold)
      .foregroundStyle(color)
      .padding(.horizontal, 8)
      .padding(.vertical, 4)
      .background(color.opacity(0.15))
      .clipShape(RoundedRectangle(cornerRadius: 6))
  }

  private func statItem(icon: String, value: String, label: String) -> some View {
    HStack(spacing: 6) {
      Image(systemName: icon)
        .font(.caption)
        .foregroundStyle(.secondary)

      VStack(alignment: .leading, spacing: 1) {
        Text(value)
          .font(.headline)
          .fontWeight(.semibold)

        Text(label)
          .font(.caption2)
          .foregroundStyle(.secondary)
      }
    }
  }
}

#Preview {
  let sampleFestival = Festival.sampleData[0]
  HStack(spacing: 6) {
    Spacer()
    FestivalCard(festival: sampleFestival)
    Spacer()
  }
}
