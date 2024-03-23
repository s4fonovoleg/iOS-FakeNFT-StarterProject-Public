import Foundation
import UIKit

final class AlertPresenter {
  // MARK: - Methods:
  static func showAlert(model: ModelOfError, controller: UIViewController) {
    let alert = UIAlertController(
      title: nil,
      message: model.message,
      preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(
      title: model.cancelText,
      style: .cancel)
    
    let action = UIAlertAction(
      title: model.actionText,
      style: .default) { _ in
        model.action()
      }
    [cancelAction, action].forEach {
      alert.addAction($0)
    }
    controller.present(alert, animated: true)
  }
}
