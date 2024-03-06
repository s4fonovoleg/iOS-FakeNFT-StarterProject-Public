import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    ReviewRequestStorage.reviewRequestCounter += 1
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = SplashViewController()
    window?.makeKeyAndVisible()
    
    return true
  }
}
