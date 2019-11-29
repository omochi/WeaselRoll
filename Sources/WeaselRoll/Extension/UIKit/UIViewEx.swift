import UIKit

public extension UIView {
    var bundle: Bundle { Bundle(for: type(of: self)) }
    
    func setContentView(_ subview: UIView) {
        subview.frame = self.bounds
        self.addSubview(subview)
        subview.bindAllEdge(to: self)
    }
    
    func bindAllEdge(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: view.leftAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}