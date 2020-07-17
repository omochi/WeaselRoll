import Foundation

extension Date {
    public func format(_ format: String,
                       timeZone: TimeZone,
                       locale: Locale) -> String {
        let f = DateFormatter()
        f.calendar = Calendar(identifier: .gregorian)
        f.dateFormat = format
        f.timeZone = timeZone
        f.locale = locale
        return f.string(from: self)
    }

    public func formatForLogFileName(timeZone: TimeZone = .current) -> String {
        return format("yyyyMMdd-HHmmss",
                      timeZone: timeZone,
                      locale: Locale(identifier: "en_US_POSIX"))
    }

    public static func -(a: Date, b: Date) -> TimeInterval {
        a.timeIntervalSince(b)
    }
}
