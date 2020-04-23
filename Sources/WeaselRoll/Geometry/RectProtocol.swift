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
