#if canImport(UIKit)

import UIKit

extension UITableView {
    public func dequeueOrCreateReusableCell<T: UITableViewCell>(
        withIdentifier identifier: String,
        create: (String) throws -> T) rethrows -> T
    {
        if let cell = dequeueReusableCell(withIdentifier: identifier) as? T {
            return cell
        }
        return try create(identifier)
    }
}

#endif
