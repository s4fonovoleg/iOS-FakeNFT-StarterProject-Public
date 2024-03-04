import Foundation
import UIKit

extension UITabBar {
  func configureTabBarAppearance() {
    UITabBar.appearance().tintColor = Asset.CustomColors.ypBlue.color
    UITabBar.appearance().unselectedItemTintColor = Asset.CustomColors.ypBlack.color
  }
}
