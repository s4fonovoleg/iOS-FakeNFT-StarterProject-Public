import UIKit
import ProgressHUD

final class UIBlockingProgressHUD {
  // MARK: - Private Properties:
  private static var window: UIWindow? {
    return UIApplication.shared.windows.first
  }
  
  // MARK: - Methods:
  static func show() {
    window?.isUserInteractionEnabled = false
    ProgressHUD.show()
    ProgressHUD.animationType = .activityIndicator
    ProgressHUD.colorAnimation = .YPBlack
    ProgressHUD.colorStatus = .YPBlack
    ProgressHUD.mediaSize = 30
    ProgressHUD.marginSize = 30
  }
  
  static func hide() {
    window?.isUserInteractionEnabled = true
    ProgressHUD.dismiss()
  }
}
