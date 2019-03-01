import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidShake), name: .ApplicationDidShakeNotification, object: nil)
        return true
    }

    @objc func applicationDidShake() {
        SnowfallController.shared.show()
    }
}

