import Foundation

public protocol ErrorBase: LocalizedError, CustomStringConvertible {}

public extension ErrorBase {
    var errorDescription: String? { description }
}
