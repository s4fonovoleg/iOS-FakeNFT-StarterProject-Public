import Foundation
import UIKit

protocol CurrencyViewModelProtocol: AnyObject {
  var onChangeLoader: ((Bool) -> Void)? { get set }
  var onChange: (() -> Void)? { get set }
  var onChangeSuccess: (() -> Void)? { get set }
  var onChangeFail: (() -> Void)? { get set }
  var currencies: [CurrencyModel] { get }
  func loadCurrencies()
  func makePayment(with currencyId: Int)
}

final class CurrencyControllerViewModel: CurrencyViewModelProtocol {
  // MARK: - Properties:
  var onChangeLoader: ((Bool) -> Void)?
  var onChange: (() -> Void)?
  var onChangeSuccess: (() -> Void)?
  var onChangeFail: (() -> Void)?
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
  
  func makePayment(with currencyId: Int) {
    onChangeLoader?(true)
    service.makePayment(id: currencyId) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let response):
        if response == true {
          print("Оплата прошла успешно")
          self.onChangeSuccess?()
        } else {
          print("Не удалось оплатить заказ")
          self.onChangeFail?()
        }
      case .failure:
        print("Не удалось оплатить заказ")
        onChangeFail?()
      }
    }
    self.onChangeLoader?(false)
  }
}
