import UIKit

final class TabBarController: UITabBarController {
  // MARK: - Private Properties:
  private let profileNavigationViewController = UINavigationController(rootViewController: UIViewController())
  private let catalogNavigationViewController = UINavigationController(rootViewController: UIViewController())
  private let cartNavigationViewController = UINavigationController(rootViewController: CartViewController(viewModel: CartViewModel(service: CartService())))
  private let statisticsNavigationViewController = UINavigationController(rootViewController: UIViewController())
  private let profileTabBarItem = UITabBarItem(title: L10n.Localizable.Button.profileTitle, image: UIImage(named: "profileIcon"), tag: 0)
  private let catalogTabBarItem = UITabBarItem(title: L10n.Localizable.Button.catalogTitle, image: UIImage(named: "catalogIcon"), tag: 1)
  private let cartTabBarItem = UITabBarItem(title: L10n.Localizable.Button.cartTitle, image: UIImage(named: "cartIcon"), tag: 2)
  private let statisticsTabBarItem = UITabBarItem(title: L10n.Localizable.Button.statisticsTitle, image: UIImage(named: "statisticsIcon"), tag: 3)
  
  // MARK: - Private Methods:
  private func setupTabs() {
    profileNavigationViewController.tabBarItem = profileTabBarItem
    catalogNavigationViewController.tabBarItem = catalogTabBarItem
    cartNavigationViewController.tabBarItem = cartTabBarItem
    statisticsNavigationViewController.tabBarItem = statisticsTabBarItem
    
    self.setViewControllers([
      profileNavigationViewController,
      catalogNavigationViewController,
      cartNavigationViewController,
      statisticsNavigationViewController
    ], animated: true)
  }
}

// MARK: - LifeCycle:
extension TabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    setupTabs()
    selectedIndex = 2
  }
}
