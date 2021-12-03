import Foundation

extension Date {
    public static func -(a: Date, b: Date) -> TimeInterval {
        a.timeIntervalSince(b)
    }

    public func format(_ formatter: DateFormatter) -> String {
        formatter.string(from: self)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    public func format(_ formatter: ISO8601DateFormatter) -> String {
        formatter.string(from: self)
    }
}
