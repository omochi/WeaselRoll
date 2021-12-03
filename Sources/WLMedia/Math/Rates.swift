public enum Rates {
    public static func rate<T: FloatingPoint>(min: T, max: T, value: T) -> T {
        return (value - min) / (max - min)
    }
    
    public static func blend<T: FloatingPoint>(min: T, max: T, rate: T) -> T {
        return max * rate + min * (T(1) - rate)
    }
}
