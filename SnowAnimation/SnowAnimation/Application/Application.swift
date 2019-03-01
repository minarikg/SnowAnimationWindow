import UIKit

extension NSNotification.Name {
    static let ApplicationDidShakeNotification = NSNotification.Name("com.application.DidShakeNotification")
}

final class Application: UIApplication {
    var lastShakeTimestamp: Date?
    
    override func sendEvent(_ event: UIEvent) {
        if event.type == .motion && event.subtype == .motionShake {
            if let lastShakeTimestamp = lastShakeTimestamp, -lastShakeTimestamp.timeIntervalSinceNow < 1 {
                return
            }
            NotificationCenter.default.post(name: .ApplicationDidShakeNotification, object: self)
            self.lastShakeTimestamp = Date()
        }
    
        super.sendEvent(event)
    }
}
