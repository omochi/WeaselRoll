public struct MessageError: ErrorBase {
    public var message: String
    
    public init(_ message: String) {
        self.message = message
    }
    
    public var description: String { message }
}
