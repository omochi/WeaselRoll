#if canImport(UIKit)

import UIKit

extension UIView {
    public var bundle: Bundle { Bundle(for: type(of: self)) }
    
    public func setContentView(_ subview: UIView) {
        subview.frame = self.bounds
        self.addSubview(subview)
        subview.bindAllEdge(to: self)
    }
    
    public func bindAllEdge(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: view.leftAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    public var ancestors: [UIView] {
        var ret: [UIView] = []
        var viewOrNone = self.superview
        while let view = viewOrNone {
            ret.append(view)
            viewOrNone = view.superview
        }
        return ret
    }
    
    public func walk(_ cont: (UIView) -> Bool) {
        guard cont(self) else {
            return
        }
        
        for v in subviews {
            guard cont(v) else {
                return
            }
        }
    }
    
    public func find<T>(_ pred: (UIView) -> T?) -> T? {
        var ret: T? = nil
        
        walk { (v) in
            if let r = pred(v) {
                ret = r
                return false
            }
            return true
        }
        
        return ret
    }
    
    public func pointInsideSubviews(_ point: CGPoint, with event: UIEvent?) -> Bool {
        for view in subviews {
            guard !view.isHidden,
                view.isUserInteractionEnabled else { continue }
            
            let point = convert(point, to: view)
            
            if view.point(inside: point, with: event) {
                return true
            }
        }
        
        return false
    }
}

#endif
