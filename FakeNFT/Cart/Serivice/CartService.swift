import Foundation

typealias NftCompletion = (Result<NFTModel, Error>) -> Void
typealias OrderCompletion = (Result<[String], Error>) -> Void

protocol CartServiceProtocol {
  func loadNft(by id: String, completion: @escaping NftCompletion)
  func loadOrder(completion: @escaping OrderCompletion)
  func updateOrder(with nfts: [String], completion: @escaping OrderCompletion)
}

final class CartService: CartServiceProtocol {
  // MARK: - Private Properties:
  private let networkClient: NetworkClient
  
  // MARK: - Methods:
  init(
    networkClient: NetworkClient = DefaultNetworkClient()) {
      self.networkClient = networkClient
    }
  
  func loadNft(by id: String, completion: @escaping NftCompletion) {
    let request = NFTRequest(id: id)
    networkClient.send(request: request, type: NFTModel.self) { result in
      switch result {
      case .success(let nft):
        completion(.success(nft))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func loadOrder(completion: @escaping OrderCompletion) {
    let request = GetOrderRequest()
    networkClient.send(request: request, type: OrderModel.self) { result in
      switch result {
      case .success(let data):
        completion(.success(data.nfts))
      case .failure(let error):
        print(error)
        completion(.failure(error))
      }
    }
  }
  
  func updateOrder(with nfts: [String], completion: @escaping OrderCompletion) {
    let request = PutOrderRequest(
      httpMethod: .put,
      dto: nfts)
    networkClient.send(request: request, type: OrderModel.self) { result in
      switch result {
      case .success(let model):
        completion(.success(model.nfts))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
