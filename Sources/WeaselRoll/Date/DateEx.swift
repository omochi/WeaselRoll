import Foundation

extension Date {
    public static func -(a: Date, b: Date) -> TimeInterval {
        a.timeIntervalSince(b)
    }

    public func format(_ formatter: DateFormatter) -> String {
        formatter.string(from: self)
    }
}
