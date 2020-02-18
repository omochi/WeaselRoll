#if os(iOS)

import UIKit

open class XIBComponentView: UIView {
    @IBOutlet public private(set) var contentView: UIView!

    @IBInspectable public var doesHitSelf: Bool = false
    
    public convenience init() {
        self.init(frame: .zero)
        frame = contentViewOriginalFrame
    }

    public override init(frame: CGRect) {
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
    
    private func loadContentView() {
        precondition(contentView == nil)
        
        var view = Self._loadContentView(owner: self)
        
        if contentView != nil {
            view = contentView
            view.removeFromSuperview()
        }
        
        contentView = view
        contentViewOriginalFrame = view.frame
        setContentView(contentView)
    }
    
    private static func _loadContentView(owner: UIView) -> UIView {
        let objs_ = owner.bundle.loadNibNamed("\(type(of: owner))", owner: owner, options: nil)
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

