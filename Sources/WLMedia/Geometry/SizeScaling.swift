extension SizeProtocol where Element: FloatingPoint {
    public func fit(width: Element) -> Self {
        Self(
            width,
            width * self.height / self.width
        )
    }

    public func fit(height: Element) -> Self {
        Self(
             height * self.width / self.height,
             height
        )
    }

    public func fit(size: Self) -> Self {
        if isWiderThan(size) {
            return fit(width: size.width)
        } else {
            return fit(height: size.height)
        }
    }

    public func fill(size: Self) -> Self {
        if isWiderThan(size) {
            return fit(height: size.width)
        } else {
            return fit(width: size.height)
        }
    }

}

extension SizeProtocol where
    Element: FloatingPoint,
    RectType.SizeType == Self
{
    public func fit(widthOf bounds: RectType) -> RectType {
        let size = self.fit(width: bounds.width)
        var origin = bounds.origin
        origin.y += (bounds.height - size.height) / 2
        return RectType(origin: origin, size: size)
    }

    public func fit(heightOf bounds: RectType) -> RectType {
        let size = self.fit(height: bounds.height)
        var origin = bounds.origin
        origin.x += (bounds.width - size.width) / 2
        return RectType(origin: origin, size: size)
    }

    public func fit(bounds: RectType) -> RectType {
        if isWiderThan(bounds.size) {
            return fit(widthOf: bounds)
        } else {
            return fit(heightOf: bounds)
        }
    }

    public func fill(bounds: RectType) -> RectType {
        if isWiderThan(bounds.size) {
            return fit(heightOf: bounds)
        } else {
            return fit(widthOf: bounds)
        }
    }
}
