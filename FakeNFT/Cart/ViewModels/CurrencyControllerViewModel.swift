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
  private let cartService = CartService()
  
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
          self.onChangeSuccess?()
          self.cartService.updateOrder(with: []) { result in // Добавил данный метод, т.к. корзина
            switch result { // не очищается самостоятельно сервером, согласовано с наставником!
            case .success:
              print("Заказ успешно обновлен")
            case .failure:
              print("Не удалось обновить заказ")
            }
          }
        } else {
          self.onChangeFail?()
        }
      case .failure:
        onChangeFail?()
      }
    }
    self.onChangeLoader?(false)
  }
}
