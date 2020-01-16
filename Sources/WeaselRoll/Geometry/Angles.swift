public enum Angles {
    public static func toRadian<X: FloatingPoint>(_ x: X) -> X {
        return x * X.pi / X(180)
    }
    
    public static func toDegree<X: FloatingPoint>(_ x: X) -> X {
        return x * X(180) / X.pi
    }
    
    public static func normalize<X: FloatingPoint>(_ x: X) -> X {
        var x = x
        while x > 180 {
            x -= 360
        }
        while x <= -180 {
            x += 360
        }
        return x
    }
}
