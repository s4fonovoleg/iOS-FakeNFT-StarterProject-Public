import Foundation
import UIKit

final class CurrencyViewController: UIViewController {
  // MARK: - Private methods:
  private func setupNavBar() {
    if navigationController?.navigationBar != nil {
      title = L10n.Localizable.Label.choosePaymentTypeTitle
    }
  }
}

// MARK: - LifeCycle:
extension CurrencyViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .YPWhite
    setupNavBar()
  }
}
