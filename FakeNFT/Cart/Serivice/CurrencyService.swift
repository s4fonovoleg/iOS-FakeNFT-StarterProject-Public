import Foundation

typealias CurrencyCompletion = (Result<CurrencyModel, Error>) -> Void

protocol CurrencyServiceProtocol: AnyObject {
  func loadCurrencies(completion: @escaping CurrencyCompletion) -> [CurrencyModel]
}

final class CurrencyService {
  // MARK: - Private Properties:
  private let networkClient: NetworkClient
  
  // MARK: - Methods:
  init(networkClient: NetworkClient) {
    self.networkClient = networkClient
  }
  
  func loadCurrencies(completion: @escaping CurrencyCompletion) -> [CurrencyModel] {
    let request = CurrenciesRequest()
    networkClient.send(request: request, type: CurrencyModel.self) { result in
      switch result {
      case .success(let currency):
        print(currency)
        completion(.success(currency))
      case .failure(let error):
        print(error)
        completion(.failure(error))
      }
    }
  }
}
