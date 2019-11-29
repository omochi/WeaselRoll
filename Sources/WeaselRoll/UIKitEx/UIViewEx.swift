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
}
