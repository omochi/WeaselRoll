public struct IntRect: RectProtocol {
    public typealias Element = Int
    public typealias SizeType = IntSize

    public var origin: IntPoint
    public var size: IntSize

    public init(origin: IntPoint, size: IntSize) {
        self.origin = origin
        self.size = size
    }
}
