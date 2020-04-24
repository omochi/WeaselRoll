public protocol SizeProtocol: Hashable, CustomStringConvertible, Codable {
    associatedtype Element: Hashable
    associatedtype PointType where PointType.Element == Self.Element
    associatedtype RectType: RectProtocol where RectType.Element == Self.Element,
    RectType.PointType == PointType,
    RectType.SizeType == Self

    var width: Element { get set }
    var height: Element { get set }

    init(_ width: Element, _ height: Element)
}

extension SizeProtocol {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        let array = try c.decode([Element].self)
        guard array.count >= 2 else {
            throw DecodingError.dataCorruptedError(in: c,
                                                   debugDescription: "array.count < 2")
        }
        self.init(array[0], array[1])
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.singleValueContainer()
        let array = [width, height]
        try c.encode(array)
    }

    public var description: String {
        "\(width)x\(height)"
    }

    public static var zero: Self {
        Self(.zero, .zero)
    }

    public func toPoint() -> PointType {
        PointType(width, height)
    }

    public static func +(a: Self, b: Self) -> Self {
        Self(a.width + b.width, a.height + b.height)
    }

    public static func +=(a: inout Self, b: Self) {
        a = a + b
    }

    public static func -(a: Self, b: Self) -> Self {
        Self(a.width - b.width, a.height - b.height)
    }

    public static func -=(a: inout Self, b: Self) {
        a = a - b
    }

    public static func *(a: Element, b: Self) -> Self {
        Self(a * b.width, a * b.height)
    }

    public static func *(a: Self, b: Element) -> Self {
        b * a
    }

    public static func *=(a: inout Self, b: Element) {
        a = a * b
    }

    public var transposed: Self {
        Self(height, width)
    }
}

extension SizeProtocol where Element: Comparable {
    public var isLandscape: Bool {
        width > height
    }

    public func isWiderThan(_ other: Self) -> Bool {
        width * other.height >= other.width * height
    }
}

extension SizeProtocol where Element: FloatingPoint {
    public static func /(a: Self, b: Element) -> Self {
        Self(a.width / b, a.height / b)
    }

    public static func /=(a: inout Self, b: Element) {
        a = a / b
    }
}

extension SizeProtocol where Element: BinaryFloatingPoint {
    public func to<T: SizeProtocol>(type: T.Type) -> T where
        T.Element: BinaryFloatingPoint
    {
        T(T.Element(width), T.Element(height))
    }
}
