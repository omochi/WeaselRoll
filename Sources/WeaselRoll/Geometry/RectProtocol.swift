public protocol RectProtocol: Hashable, CustomStringConvertible, Codable {
    associatedtype Element
    associatedtype PointType: PointProtocol where PointType.Element == Self.Element
    associatedtype SizeType where SizeType == PointType.SizeType

    var origin: PointType { get set }
    var size: SizeType { get set }

    init(origin: PointType, size: SizeType)
}

extension RectProtocol {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(width)
        hasher.combine(height)
    }

    public var description: String {
        "\(x), \(y), \(width)x\(height)"
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        let array = try c.decode([Element].self)
        guard array.count >= 4 else {
            throw DecodingError.dataCorruptedError(in: c,
                                                   debugDescription: "array.count < 4")
        }
        self.init(x: array[0], y: array[1], width: array[2], height: array[3])
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.singleValueContainer()
        let array = [x, y, width, height]
        try c.encode(array)
    }

    public var x: Element {
        origin.x
    }

    public var y: Element {
        origin.y
    }

    public var width: Element {
        size.width
    }

    public var height: Element {
        size.height
    }

    public init(x: Element, y: Element, width: Element, height: Element) {
        self.init(origin: PointType(x, y),
                  size: SizeType(width, height))
    }

    public var minX: Element {
        x
    }
    public var maxX: Element {
        x + width
    }

    public var minY: Element {
        y
    }
    public var maxY: Element {
        y + height
    }

    public var left: Element {
        x
    }

    public var top: Element {
        y
    }

    public var right: Element {
        x + width
    }

    public var bottom: Element {
        y + height
    }

    public var topLeft: PointType {
        PointType(left, top)
    }

    public var topRight: PointType {
        PointType(right, top)
    }

    public var bottomLeft: PointType {
        PointType(left, bottom)
    }

    public var bottomRight: PointType {
        PointType(right, bottom)
    }
}

extension Array where Element: PointProtocol, Element.Element: Comparable {
    public func bounding() -> Element.RectType {
        let x0 = map { $0.x }.min()!
        let x1 = map { $0.x }.max()!
        let y0 = map { $0.y }.min()!
        let y1 = map { $0.y }.max()!
        return Element.RectType(x: x0, y: y0, width: x1 - x0, height: y1 - y0)
    }
}

extension RectProtocol where Element: FloatingPoint {
    public init(center: PointType, size: SizeType) {
        self.init(origin: center - size / 2,
                  size: size)
    }

    public var midX: Element {
        x + width / 2
    }

    public var midY: Element {
        y + height / 2
    }

    public var center: PointType {
        origin + size / 2
    }
}

extension RectProtocol where Element: BinaryFloatingPoint {
    public func to<T: RectProtocol>(type: T.Type) -> T where
        T.Element: BinaryFloatingPoint
    {
        T(origin: origin.to(type: T.PointType.self),
          size: size.to(type: T.SizeType.self))
    }
}
