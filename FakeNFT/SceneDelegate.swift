import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let screen = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: screen)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
}
