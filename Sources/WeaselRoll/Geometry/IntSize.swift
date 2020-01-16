import CoreGraphics

public struct IntSize: Hashable {
    public var width: Int
    public var height: Int
    
    public init(width: Int,
                height: Int)
    {
        self.width = width
        self.height = height
    }
    
    public func toFloat() -> Size {
        Size(width: Float(width), height: Float(height))
    }
    
    public func toCGSize() -> CGSize {
        CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    public var transposed: IntSize {
        IntSize(width: height, height: width)
    }
}
