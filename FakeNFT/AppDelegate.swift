import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  let tabBarController = TabBarController()
  
  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    tabBarController.tabBar.configureTabBarAppearance()
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController =  ThirdPageViewController()//tabBarController 
    window?.makeKeyAndVisible()
    
    return true
  }
}
