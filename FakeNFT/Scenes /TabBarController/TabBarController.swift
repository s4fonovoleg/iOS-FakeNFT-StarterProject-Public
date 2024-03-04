import UIKit

final class TabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly!

    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 1
    )
    
    private let profileTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.profile", comment: ""),
        image: UIImage(systemName: "person.crop.circle.fill"),
        tag: 0
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Задать значение токена после успешной авторизации, например, через Keychain
        NetworkSessionToken.shared.token = "77bd726b-15bc-4ad3-92c4-c4c97adb9491"
        
        let profileController = ProfileNavigationController(
            servicesAssembly: servicesAssembly
        )
        
        profileController.tabBarItem = profileTabBarItem

        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
        
        catalogController.tabBarItem = catalogTabBarItem
        
        viewControllers = [profileController, catalogController]

        view.backgroundColor = .systemBackground
    }
}
