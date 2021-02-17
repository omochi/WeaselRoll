import Foundation

extension DateFormatter {
    public convenience init(
        calendar: Calendar,
        locale: Locale,
        timeZone: TimeZone,
        format: String
    ) {
        self.init()
        self.dateFormat = format
        self.calendar = calendar
        self.locale = locale
        self.timeZone = timeZone
    }

    public static func logFileName(timeZone: TimeZone = .current) -> DateFormatter {
        return DateFormatter(
            calendar: .gregorian,
            locale: .posix,
            timeZone: timeZone,
            format: "yyyyMMdd-HHmmss"
        )
    }
}
