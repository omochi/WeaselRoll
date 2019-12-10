import Foundation

extension Date {
    public static func +(a: Date, b: TimeInterval) -> Date {
        a.addingTimeInterval(b)
    }
    
    public static func +=(a: inout Date, b: TimeInterval) {
        a = a + b
    }
    
    public static func -(a: Date, b: TimeInterval) -> Date {
        a.addingTimeInterval(-b)
    }
    
    public static func -=(a: inout Date, b: TimeInterval) {
        a = a - b
    }
    
    public static func -(a: Date, b: Date) -> TimeInterval {
        a.timeIntervalSince(b)
    }
}
