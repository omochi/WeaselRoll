extension DefaultStringInterpolation {
    public mutating func appendInterpolation<T>(
        _ x: Optional<T>,
        _ defaultValue: String
    ) where
        T: TextOutputStreamable,
        T: CustomStringConvertible
    {
        if let x = x {
            self.appendInterpolation(x)
        } else {
            self.appendInterpolation(defaultValue)
        }
    }

    public mutating func appendInterpolation<T>(
        _ x: Optional<T>,
        _ defaultValue: String
    ) where
        T: TextOutputStreamable
    {
        if let x = x {
            self.appendInterpolation(x)
        } else {
            self.appendInterpolation(defaultValue)
        }
    }

    public mutating func appendInterpolation<T>(
        _ x: Optional<T>,
        _ defaultValue: String
    ) where
        T: CustomStringConvertible
    {
        if let x = x {
            self.appendInterpolation(x)
        } else {
            self.appendInterpolation(defaultValue)
        }
    }

    public mutating func appendInterpolation<T>(
        _ x: Optional<T>,
        _ defaultValue: String
    ) {
        if let x = x {
            self.appendInterpolation(x)
        } else {
            self.appendInterpolation(defaultValue)
        }
    }
}
