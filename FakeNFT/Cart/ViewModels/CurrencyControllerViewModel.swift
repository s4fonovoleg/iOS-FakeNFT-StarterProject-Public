import Foundation
import UIKit

protocol CurrencyViewModelProtocol: AnyObject {
  var onChangeLoader: ((Bool) -> Void)? { get set }
  var onChange: (() -> Void)? { get set }
  func loadCurrencies()
  var currencies: [CurrencyModel] { get }
}

final class CurrencyControllerViewModel: CurrencyViewModelProtocol {
  // MARK: - Properties:
  var onChangeLoader: ((Bool) -> Void)?
  var onChange: (() -> Void)?
  var currencies: [CurrencyModel] = [] {
    didSet {
      onChange?()
    }
  }
  // MARK: - Private Properties:
  private let service: CurrencyServiceProtocol
  
  // MARK: - Methods:
  init(service: CurrencyServiceProtocol) {
    self.service = service
  }
  
  func loadCurrencies() {
    onChangeLoader?(true)
    service.loadCurrencies { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let currencies):
        self.currencies = currencies
      case .failure(let error):
        print(error.localizedDescription)
      }
      self.onChangeLoader?(false)
    }
  }
  
}
