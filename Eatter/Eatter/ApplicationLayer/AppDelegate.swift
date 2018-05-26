import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var rootCoordinator: Coordinator = makeRootCoonrdinator()

    // MARK: - API
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        rootCoordinator.start()
        return true
    }
    
    // MARK: - Private API
    private func makeRootCoonrdinator() -> Coordinator {
        if let navigationVC = window?.rootViewController as? UINavigationController {
            return SearchCoordinator(rootVC: navigationVC)
        } else {
            fatalError("Unexpected root view controller value")
        }
    }
    
}

