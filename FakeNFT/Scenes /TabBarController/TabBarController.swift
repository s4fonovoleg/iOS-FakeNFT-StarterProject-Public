import UIKit

final class TabBarController: UITabBarController {
  // MARK: - Private Properties:
  private let profileNavigationViewController = UINavigationController(rootViewController: UIViewController())
  private let catalogNavigationViewController = UINavigationController(rootViewController: CatalogView())
  private let cartNavigationViewController = UINavigationController(rootViewController: CartViewController(viewModel: CartViewModel(service: CartService())))
  private let statisticsNavigationViewController = UINavigationController(rootViewController: StatisticsViewController())
  private let profileTabBarItem = UITabBarItem(title: L10n.Localizable.Button.profileTitle, image: Asset.CustomIcons.profileIcon.image, tag: 0)
  private let catalogTabBarItem = UITabBarItem(title: L10n.Localizable.Button.catalogTitle, image: Asset.CustomIcons.catalogIcon.image, tag: 1)
  private let cartTabBarItem = UITabBarItem(title: L10n.Localizable.Button.cartTitle, image: Asset.CustomIcons.cartIcon.image, tag: 2)
  private let statisticsTabBarItem = UITabBarItem(title: L10n.Localizable.Button.statisticsTitle, image: Asset.CustomIcons.statisticsIcon.image, tag: 3)
  
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
    tabBar.isTranslucent = false
    view.backgroundColor = .systemBackground
    setupTabs()
    selectedIndex = 1
  }
}
