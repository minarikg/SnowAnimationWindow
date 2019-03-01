import UIKit

public func main() {
    _ = UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), NSStringFromClass(Application.self), NSStringFromClass(AppDelegate.self))
}

main()
