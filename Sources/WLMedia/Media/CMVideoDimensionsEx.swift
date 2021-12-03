#if canImport(CoreMedia)

import CoreMedia

extension IntSize {
    public func toCMVideoDimensions() -> CMVideoDimensions {
        return CMVideoDimensions(width: Int32(width), height: Int32(height))
    }
}

extension CMVideoDimensions {
    public func toIntSize() -> IntSize {
        return IntSize(Int(width), Int(height))
    }
}

#endif

