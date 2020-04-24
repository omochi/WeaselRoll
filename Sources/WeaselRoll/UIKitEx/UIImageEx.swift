#if os(iOS)

import UIKit

extension UIImage {
    public var bounds: CGRect {
        CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }

    public var width: CGFloat {
        size.width
    }

    public var height: CGFloat {
        size.height
    }

    public convenience init?(contentsOf file: URL) {
        self.init(contentsOfFile: file.path)
    }
    
    /**
     - Parameters:
        - scale: nilはデバイス密度。
     - Returns: sizeの縦か横が0だとnilになる。
     */
    public static func render(size: CGSize,
                              scale: CGFloat? = nil,
                              render: (CGContext) -> Void) -> UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale ?? 0)
        defer { UIGraphicsEndImageContext() }
            
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        render(context)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public static func filled(size: CGSize,
                              scale: CGFloat? = nil,
                              color: UIColor) -> UIImage?
    {
        return UIImage.render(size: size, scale: scale) { (context) in
            let bounds = CGRect(origin: .zero, size: size)
            color.setFill()
            context.fill(bounds)
        }
    }

    /// 標準のtintとは異なり、グレーが指定色になり、白黒は保持される。
    public func colored(_ color: UIColor) -> UIImage {
        return UIImage.render(size: size, scale: scale) { (context) in
            draw(in: bounds)
            
            color.setFill()
            UIRectFillUsingBlendMode(bounds, .overlay)
            
            // Copy alpha of src image
            draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        }!
    }
    
    public func resized(size: CGSize, scale: CGFloat) -> UIImage? {
        return UIImage.render(size: size, scale: scale) { (context) in
            let frame = CGRect(origin: .zero, size: size)
            self.draw(in: frame)
        }
    }
    
    public func sizeCapped(maxSize: CGSize) -> UIImage {
        if size.width > maxSize.width ||
            size.height > maxSize.height
        {
            let newSize = size.fit(size: maxSize)
            return resized(size: newSize, scale: 1)!
        }
        return self
    }
    
    public func circleClipped(background: UIColor?) -> UIImage {
        return UIImage.render(size: size, scale: scale) { (context) in
            context.addEllipse(in: bounds)
            context.clip()
            
            if let background = background {
                background.setFill()
                context.fill(bounds)
            }
            
            self.draw(in: bounds)
        }!
    }
    
    public func roundedRectClipped(background: UIColor?,
                                   cornerRadius: CGFloat) -> UIImage {
        return UIImage.render(size: size, scale: scale) { (context) in
            
            let rectPath = CGPath(roundedRect: bounds,
                                  cornerWidth: cornerRadius,
                                  cornerHeight: cornerRadius,
                                  transform: nil)
            context.addPath(rectPath)
            context.clip()
            
            if let background = background {
                background.setFill()
                context.fill(bounds)
            }
            
            self.draw(in: bounds)
        }!
    }

    public func rotated(angle: Angle90) -> UIImage {
        let newSize =  angle.rotate(size: size)
        return UIImage.render(size: newSize, scale: scale) { (context) in
            let tr = angle.toImageRotation(size: size)
            context.concatenate(tr)
            self.draw(at: .zero)
        }!
    }
}

#endif
