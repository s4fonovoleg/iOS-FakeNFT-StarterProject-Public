import Foundation
import UIKit

final class SortingAlertPresenter {
  // MARK: - Methods:
  static func showAlert(model: SortingAlertModel, controller: UIViewController) {
    let alert = UIAlertController(
      title: model.title,
      message: model.message,
      preferredStyle: .actionSheet)
    
    let sortByPriceAction = UIAlertAction(
      title: model.firstButtonText,
      style: .default) { _ in
        model.firstCompletion()
      }
    
    let sortByRatingAction = UIAlertAction(
      title: model.secondButtonText,
      style: .default) { _ in
        model.secondCompletion()
      }
    
    let sortByNameAction = UIAlertAction(
      title: model.thirdButtonText,
      style: .default) { _ in
        model.thirdCompletion()
      }
    
    let closeAction = UIAlertAction(
      title: model.fourthButtonText,
      style: .cancel)
    
    alert.addAction(closeAction)
    alert.addAction(sortByPriceAction)
    alert.addAction(sortByRatingAction)
    alert.addAction(sortByNameAction)
    
    controller.present(alert, animated: true)
  }
}
