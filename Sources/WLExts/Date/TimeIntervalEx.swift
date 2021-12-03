import Foundation

extension TimeInterval {
    public func toDispatch() -> DispatchTimeInterval {
        return .milliseconds(Int(self * 1000))
    }
}
