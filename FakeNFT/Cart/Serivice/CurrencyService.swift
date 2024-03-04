import Foundation

typealias CurrencyCompletion = (Result<[CurrencyModel], Error>) -> Void
typealias PaymentCompletion = (Result<Bool, Error>) -> Void

protocol CurrencyServiceProtocol: AnyObject {
  func loadCurrencies(completion: @escaping CurrencyCompletion)
  func makePayment(id: Int, completion: @escaping PaymentCompletion)
}

final class CurrencyService: CurrencyServiceProtocol {
  // MARK: - Private Properties:
  private let networkClient: NetworkClient
  
  // MARK: - Methods:
  init(networkClient: NetworkClient = DefaultNetworkClient()) {
    self.networkClient = networkClient
  }
  
  func loadCurrencies(completion: @escaping CurrencyCompletion) {
    let request = CurrenciesRequest()
    networkClient.send(request: request, type: [CurrencyModel].self) { result in
      switch result {
      case .success(let currencies):
        completion(.success(currencies))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func makePayment(id: Int, completion: @escaping PaymentCompletion) {
    let request = PaymentRequest(currencyId: id)
    networkClient.send(request: request, type: PaymentModel.self) { result in
      switch result {
      case .success(let model):
        completion(.success(model.success))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
