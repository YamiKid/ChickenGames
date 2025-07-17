
import UIKit

@main
class HatchCoopClickerAppDelegate: UIResponder, UIApplicationDelegate {

    var HatchCoopClickerWindow: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        HatchCoopClickerWindow = UIWindow(frame: UIScreen.main.bounds)
        let HatchCoopClickerLoadingVC = HatchCoopClickerLoadingVC()
        HatchCoopClickerWindow?.rootViewController = HatchCoopClickerLoadingVC
        HatchCoopClickerWindow?.makeKeyAndVisible()
        return true
    }
}

