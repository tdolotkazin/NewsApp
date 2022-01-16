import Foundation

extension Date {
  static func fromString(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .iso8601)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
    return dateFormatter.date(from: dateString)
  }
}

extension Date {
  static func toString(_ date: Date?) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    dateFormatter.timeZone = .current
    if let date = date {
      return dateFormatter.string(from: date)
    } else {
      return nil
    }
  }
}
