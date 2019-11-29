import UIKit

public extension UIViewController {
    var bundle: Bundle { Bundle(for: type(of: self)) }
    
    func presentFullscreen(_ vc: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: animated, completion: completion)
    }
}
