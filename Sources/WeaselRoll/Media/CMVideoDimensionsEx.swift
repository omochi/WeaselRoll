import CoreMedia

extension IntSize {
    public func toCMVideoDimensions() -> CMVideoDimensions? {
        guard let w = Int32(exactly: width),
            let h = Int32(exactly: height) else { return nil }
        return CMVideoDimensions(width: w, height: h)
    }
}

extension CMVideoDimensions {
    public func toIntSize() -> IntSize? {
        guard let w = Int(exactly: width),
            let h = Int(exactly: height) else { return nil }
        return IntSize(width: w, height: h)
    }
}
