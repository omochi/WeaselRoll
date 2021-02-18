extension DefaultStringInterpolation {
    public mutating func appendInterpolation<T>(
        debug x: T,
        _ defaultValue: String
    ) where
        T: TextOutputStreamable,
        T: CustomStringConvertible
    {
        if let x = x as? CustomDebugStringConvertible {
            appendInterpolation(x.debugDescription)
        } else {
            appendInterpolation(x)
        }
    }

    public mutating func appendInterpolation<T>(
        debug x: T,
        _ defaultValue: String
    ) where
        T: TextOutputStreamable
    {
        if let x = x as? CustomDebugStringConvertible {
            appendInterpolation(x.debugDescription)
        } else {
            appendInterpolation(x)
        }
    }

    public mutating func appendInterpolation<T>(
        debug x: T,
        _ defaultValue: String
    ) where
        T: CustomStringConvertible
    {
        if let x = x as? CustomDebugStringConvertible {
            appendInterpolation(x.debugDescription)
        } else {
            appendInterpolation(x)
        }
    }

    public mutating func appendInterpolation<T>(
        debug x: T,
        _ defaultValue: String
    ) {
        if let x = x as? CustomDebugStringConvertible {
            appendInterpolation(x.debugDescription)
        } else {
            appendInterpolation(x)
        }
    }
}

extension String {
    public init<X>(debugDescribing x: X) {
        if let x = x as? CustomDebugStringConvertible {
            self = x.debugDescription
        } else {
            self = String(describing: x)
        }
    }
}
