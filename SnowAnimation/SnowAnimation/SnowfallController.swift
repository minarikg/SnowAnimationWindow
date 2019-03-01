import UIKit

public final class SnowfallController {
    public static let shared = SnowfallController()

    private var window: UIWindow?
    
    private init() {}
    
    public func show() {
        assert(Thread.isMainThread)
        
        guard window == nil else { return }
        
        let viewController = SnowfallViewController()

        window = SnowfallWindow()
        window?.isHidden = false
        window?.rootViewController = viewController
        
        viewController.show()
    }
    
    public func hide(completion: (() -> Void)? = nil) {
        assert(Thread.isMainThread)
        
        guard let window = window else { completion?(); return }
        guard let viewController = window.rootViewController as? SnowfallViewController else { fatalError() }
        
        viewController.hide { [unowned self] in
            self.window = nil
            completion?()
        }
    }
}

private final class SnowfallWindow: UIWindow {
    init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView!.isKind(of: IgnoreTouchView.self) {
            return nil
        }

        return hitView
    }
}

private final class SnowfallViewController: UIViewController {
    private let animationDuration = 1.0
    
    private let snowFlakeEmitter = SnowFlakeEmitter()
    
    private let backgroundView: UIView = {
        let backgroundView = IgnoreTouchView()
        backgroundView.backgroundColor = .clear
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    override func loadView() {
        view = backgroundView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        snowFlakeEmitter.injectSnowLayer(into: backgroundView)
    }
    
    func show() {        
        backgroundView.alpha = 1
    }
    
    func hide(after delay: TimeInterval = 8, completion: @escaping () -> Void) {
        snowFlakeEmitter.stop()

        UIView.animate(withDuration: animationDuration, delay: delay, animations: { [backgroundView] in
            backgroundView.alpha = 0
        }, completion: { _ in
            completion()
        })
    }
}

private final class IgnoreTouchView: UIView {}
