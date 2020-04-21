@propertyWrapper
public struct LateInit<T> {
    private var value: T?

    public init() {
        value = nil
    }

    public var wrappedValue: T {
        get {
            guard let value = self.value else {
                preconditionFailure("[LateInit] value is not initialized")
            }
            return value
        }
        set {
            value = newValue
        }
    }
}
