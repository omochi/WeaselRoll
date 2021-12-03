import WeaselRoll

extension DefaultStringInterpolation {
    public mutating func appendInterpolation<T>(
        _ x: Optional<T>,
        _ default: String
    ) where
        T: TextOutputStreamable & CustomStringConvertible
    {
        appendInterpolation(describe(x, `default`))
    }

    public mutating func appendInterpolation<T>(
        _ x: Optional<T>,
        _ default: String
    ) where
        T: TextOutputStreamable
    {
        appendInterpolation(describe(x, `default`))
    }

    public mutating func appendInterpolation<T>(
        _ x: Optional<T>,
        _ default: String
    ) where
        T: CustomStringConvertible
    {
        appendInterpolation(describe(x, `default`))
    }

    public mutating func appendInterpolation<T>(
        _ x: Optional<T>,
        _ default: String
    ) {
        appendInterpolation(describe(x, `default`))
    }
}
