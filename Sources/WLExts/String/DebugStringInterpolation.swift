import WeaselRoll

extension DefaultStringInterpolation {
    public mutating func appendInterpolation<T>(
        debug x: T
    ) where
        T: TextOutputStreamable & CustomStringConvertible
    {
        appendInterpolation(describe(debug: x))
    }

    public mutating func appendInterpolation<T>(
        debug x: T
    ) where
        T: TextOutputStreamable
    {
        appendInterpolation(describe(debug: x))
    }

    public mutating func appendInterpolation<T>(
        debug x: T
    ) where
        T: CustomStringConvertible
    {
        appendInterpolation(describe(debug: x))
    }

    public mutating func appendInterpolation<T>(
        debug x: T
    ) {
        appendInterpolation(describe(debug: x))
    }
}
