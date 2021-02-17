public enum Angle90: Int {
    case minus90 = -90
    case _0 = 0
    case _90 = 90
    case _180 = 180
    
    public init?<X: BinaryFloatingPoint>(_ angle: X) {
        let angle = Angles.normalize(angle)
        guard let intAngle = Int(exactly: angle) else { return nil }
        guard let angle90 = Angle90(rawValue: intAngle) else { return nil }
        self = angle90
    }

    public func rotate<T: SizeProtocol>(size: T) -> T {
        switch self {
        case ._0, ._180: return size
        case ._90, .minus90: return size.transposed
        }
    }
}
