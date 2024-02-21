import UIKit

final class TabBarController: UITabBarController {

    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 0
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        let catalogController = UINavigationController(rootViewController: CatalogViewController())
        catalogController.tabBarItem = catalogTabBarItem
        catalogController.navigationBar.barTintColor = UIColor(named: "WhiteColor")
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor(named: "WhiteColor")
        tabBar.tintColor = .systemBlue
        viewControllers = [catalogController]
        view.backgroundColor = UIColor(named: "WhiteColor")
    }
}
