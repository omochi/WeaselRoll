#if canImport(UIKit)

import UIKit

open class XIBComponentView: UIView {
    @IBOutlet public private(set) var contentView: UIView!

    @IBInspectable public var doesHitSelf: Bool = false
    
    public convenience required init() {
        self.init(frame: .zero)
        frame = contentViewOriginalFrame
    }

    public override required init(frame: CGRect) {
        super.init(frame: frame)
        loadContentView()
        didInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadContentView()
        didInit()
    }
    
    public var contentViewOriginalFrame: CGRect = .zero

    open var nibName: String {
        "\(type(of: self))"
    }
    
    private func loadContentView() {
        precondition(contentView == nil)
        
        var view = Self._loadContentView(nibName: self.nibName)
        
        if contentView != nil {
            view = contentView
            view.removeFromSuperview()
        }
        
        contentView = view
        contentViewOriginalFrame = view.frame
        setContentView(contentView)
    }
    
    private static func _loadContentView(nibName: String) -> UIView {
        let objs_ = owner.bundle.loadNibNamed(nibName, owner: owner, options: nil)
        let objs = objs_!
        let obj = objs[0]
        let view = obj as! UIView
        return view
    }
    
    open func didInit() {}
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if doesHitSelf {
            return super.point(inside: point, with: event)
        } else {
            return pointInsideSubviews(point, with: event)
        }
    }
}

#endif

