public func describe<T>(_ x: T) -> String where
    T: TextOutputStreamable & CustomStringConvertible {
    String(describing: x)
}

public func describe<T>(_ x: T) -> String where
    T: TextOutputStreamable {
    String(describing: x)
}

public func describe<T>(_ x: T) -> String where
    T: CustomStringConvertible {
    String(describing: x)
}

public func describe<T>(_ x: T) -> String {
    String(describing: x)
}

public func describe<T>(
    _ x: Optional<T>,
    _ `default`: String
) -> String where
    T: TextOutputStreamable & CustomStringConvertible
{
    if let x = x {
        return describe(x)
    } else {
        return `default`
    }
}

public func describe<T>(
    _ x: Optional<T>,
    _ `default`: String
) -> String where
    T: TextOutputStreamable
{
    if let x = x {
        return describe(x)
    } else {
        return `default`
    }
}

public func describe<T>(
    _ x: Optional<T>,
    _ `default`: String
) -> String where
    T: CustomStringConvertible
{
    if let x = x {
        return describe(x)
    } else {
        return `default`
    }
}

public func describe<T>(
    _ x: Optional<T>,
    _ `default`: String
) -> String {
    if let x = x {
        return describe(x)
    } else {
        return `default`
    }
}

public func describe<T>(debug x: T) -> String where
    T: TextOutputStreamable & CustomStringConvertible
{
    if let x = x as? CustomDebugStringConvertible {
        return x.debugDescription
    } else {
        return describe(x)
    }
}

public func describe<T>(debug x: T) -> String where
    T: TextOutputStreamable
{
    if let x = x as? CustomDebugStringConvertible {
        return x.debugDescription
    } else {
        return describe(x)
    }
}

public func describe<T>(debug x: T) -> String where
    T: CustomStringConvertible
{
    if let x = x as? CustomDebugStringConvertible {
        return x.debugDescription
    } else {
        return describe(x)
    }
}

public func describe<T>(debug x: T) -> String {
    if let x = x as? CustomDebugStringConvertible {
        return x.debugDescription
    } else {
        return describe(x)
    }
}
