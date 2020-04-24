#if canImport(UIKit)

import UIKit

extension UIViewController {
    public var bundle: Bundle { Bundle(for: type(of: self)) }
    
    public func presentFullscreen(_ vc: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: animated, completion: completion)
    }
}

#endif
