import Foundation

extension Date {
    public init?(iso8601 string: String) {
        let impl = DateParseISO8601()
        guard let date = impl.parse(string) else {
            return nil
        }
        self = date
    }
    
    public func iso8601(options: DateFormatISO8601.Options = .init()) -> String {
        let impl = DateFormatISO8601()
        return impl.format(date: self, options: options)
    }
}

public final class DateFormatISO8601 {
    public struct Options {
        public var timeZone: TimeZone
        public var separatorForDateAndTime: String
        public var numberOfDecimalPlacesForSecond: Int
        public var timeSeparator: String

        public init(timeZone: TimeZone = TimeZone.current,
                    separatorForDateAndTime: String = "T",
                    numberOfDecimalPlacesForSecond: Int = 3,
                    timeSeparator: String = ":")
        {
            self.timeZone = timeZone
            self.separatorForDateAndTime = separatorForDateAndTime
            self.numberOfDecimalPlacesForSecond = numberOfDecimalPlacesForSecond
            self.timeSeparator = timeSeparator
        }
    }
    
    public init() {
        self.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    }
    
    public func format(date: Date, options: Options) -> String {
        let components: DateComponents = calendar.dateComponents(in: options.timeZone, from: date)
        
        let ymdStr = String(format: "%04d-%02d-%02d",
                            components.year!,
                            components.month!,
                            components.day!)
        
        func _hmsStr() -> String {
            let hourStr = String(format: "%02d", components.hour!)
            let minuteStr = String(format: "%02d", components.minute!)
            let secondStr = String(format: "%02d", components.second!)
            let sep = options.timeSeparator
            return "\(hourStr)\(sep)\(minuteStr)\(sep)\(secondStr)"
        }
        
        let hmsStr = _hmsStr()

        func _deciStr() -> String {
            let num = options.numberOfDecimalPlacesForSecond
            
            if num == 0 {
                return ""
            }
            
            var value = Double(components.nanosecond ?? 0)
            var valueNum = 9
            
            while num < valueNum {
                value /= 10
                valueNum -= 1
            }
            
            return String(format: ".%0\(num)d", Int(round(value)))
        }
        
        let deciStr = _deciStr()
        
        func _timeZoneStr() -> String {
            let offset = options.timeZone.secondsFromGMT()
            let signStr = offset >= 0 ? "+" : "-"
            let hour = abs(offset) / 3600
            let minute = abs(offset) / 60 % 60
            let hmStr = String(format: "%02d:%02d", hour, minute)
            return "\(signStr)\(hmStr)"
        }
        
        let tzStr = _timeZoneStr()

        let sep = options.separatorForDateAndTime
        return "\(ymdStr)\(sep)\(hmsStr)\(deciStr)\(tzStr)"
    }

    private let calendar: Calendar
}

public final class DateParseISO8601 {
    public init() {
        self.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let regexStr = "^(\\d+)[/-](\\d+)[/-](\\d+)[ T](\\d+)[:\\-](\\d+)[:\\-](\\d+)(?:\\.(\\d+))?(?:Z|(\\+|-)(\\d+):(\\d+))?$"
        self.regex = Regex(pattern: regexStr, options: [])
    }
    
    public func parse(_ string: String) -> Date? {
        guard let match = regex.match(string: string, options: []) else {
            return nil
        }
        
        guard let year = Int(match[1]!),
            let month = Int(match[2]!),
            let day = Int(match[3]!),
            let hour = Int(match[4]!),
            let minute = Int(match[5]!),
            let second = Int(match[6]!) else {
                return nil
        }
        
        func nanosecond() -> Int? {
            guard var partStr = match[7] else {
                return 0
            }
            partStr = String(partStr.prefix(9))
            guard var value = Int(partStr) else {
                return nil
            }
            for _ in 0..<(9 - partStr.count) {
                value *= 10
            }
            
            return value
        }
        
        guard let nanoSecond = nanosecond() else {
            return nil
        }
        
        func timeZoneOffset() -> Int? {
            guard let signPartStr = match[8] else {
                return 0
            }
            
            let sign: Int = signPartStr == "+" ? +1 : -1
            guard let hour = Int(match[9]!),
                let minute = Int(match[10]!) else
            {
                return nil
            }
            
            return sign * (hour * 3600 + minute * 60)
        }
        
        guard let timeZoneOffset = timeZoneOffset() else {
            return nil
        }
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanoSecond
        components.timeZone = TimeZone(secondsFromGMT: timeZoneOffset)!
        
        return calendar.date(from: components)!
    }
    
    private let calendar: Calendar
    private let regex: Regex
}

