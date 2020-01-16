import Foundation

public enum Randoms {
    public static func randomString(length: Int) -> String {
        RandomString.shared.call(length: length)
    }
    
    private struct RandomString {
        public static let shared = RandomString()
        
        private let chars: [Character]
        
        public init() {
            chars = """
            abcdefghijklmnopqrstuvwxyz\
            ABCDEFGHIJKLMNOPQRSTUVWXYZ\
            0123456789
            """
                .map { $0 }
        }
        
        public func call(length: Int) -> String {
            var str = ""
            for _ in 0..<length {
                str.append(chars.randomElement()!)
            }
            return str
        }
    }
}
