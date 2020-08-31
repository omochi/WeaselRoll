import Foundation

extension Data {
    public func toString(encoding: String.Encoding = .utf8) -> String? {
        String(data: self, encoding: encoding)
    }

    public func toDebugStringForUTF8(limit: Int? = 1000) -> String {
        guard var str = String(data: self, encoding: .utf8) else {
            return "(size=\(count), content=<binary>)"
        }

        if let limit = limit, str.count > limit {
            let end = str.index(str.startIndex, offsetBy: limit)
            str = String(str[..<end]) + "..."
        }

        return "(size=\(count), content=\(str))"
    }
}
