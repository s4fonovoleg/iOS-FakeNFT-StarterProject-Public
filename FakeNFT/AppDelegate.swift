import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  let servicesAssembly = ServicesAssembly(
    networkClient: DefaultNetworkClient(),
    nftStorage: NftStorageImpl()
  )
  let tabBarController = TabBarController()
  
  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    tabBarController.servicesAssembly = servicesAssembly
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
    
    return true
  }
}
