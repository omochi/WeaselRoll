import CoreMedia

extension Rational {
    public func toCMTime() -> CMTime? {
        guard let value = CMTimeValue(exactly: value),
            let scale = CMTimeScale(exactly: scale) else { return nil }
        return CMTime(value: value, timescale: scale)
    }
}

extension CMTime {
    public func toRational() -> Rational? {
        guard let value = Int(exactly: value),
            let scale = Int(exactly: timescale) else { return nil }
        return Rational(value: value, scale: scale)
    }
}
