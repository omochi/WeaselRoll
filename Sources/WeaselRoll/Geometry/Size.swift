import CoreGraphics

public struct Size: Hashable {
    public var width: Float
    public var height: Float
    
    public init(width: Float,
                height: Float)
    {
        self.width = width
        self.height = height
    }
    
    public func toInt() -> IntSize {
        IntSize(width: Int(width), height: Int(height))
    }
    
    public func toCGSize() -> CGSize {
        CGSize(width: CGFloat(width), height: CGFloat(height))
    }
}

extension CGSize {
    public func toSize() -> Size {
        Size(width: Float(width), height: Float(height))
    }
    
    public func toIntSize() -> IntSize {
        IntSize(width: Int(width), height: Int(height))
    }
}
