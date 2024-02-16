import Foundation

typealias NftCompletion = (Result<NFTModel, Error>) -> Void
typealias NFTsCompletion = (Result<[String], Error>) -> Void

protocol CartServiceProtocol {
  func loadNft(id: String, completion: @escaping NftCompletion)
  func loadOrder(completion: @escaping NFTsCompletion)
  func updateOrder(with nfts: [String], completion: @escaping NFTsCompletion)
}

final class CartService: CartServiceProtocol {
  // MARK: - Private Properties:
  private let networkClient: NetworkClient
  private var storage = NFTsStorage.nfts
  
  // MARK: - Methods:
  init(
    networkClient: NetworkClient = DefaultNetworkClient()) {
      self.networkClient = networkClient
    }
  
  func loadNft(id: String, completion: @escaping NftCompletion) {
    let request = NFTRequest(id: id)
    networkClient.send(request: request, type: NFTModel.self) { result in
      switch result {
      case .success(let nft):
        print("Request secceeded")
        self.storage.append(nft.id)
        completion(.success(nft))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func loadOrder(completion: @escaping NFTsCompletion) {
    if !NFTsStorage.nfts.isEmpty {
      completion(.success(NFTsStorage.nfts))
      return
    }
    
    let request = GetOrderRequest()
    networkClient.send(request: request, type: OrderModel.self) { result in
      assert(Thread.isMainThread)
      switch result {
      case .success(let data):
        NFTsStorage.nfts = data.nfts
        completion(.success(data.nfts))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func updateOrder(with nfts: [String], completion: @escaping NFTsCompletion) {
    assert(Thread.isMainThread)
    let request = PutOrderRequest(
      httpMethod: .put,
      dto: nfts)
    networkClient.send(request: request, type: OrderModel.self) { result in
      switch result {
      case .success(let model):
        NFTsStorage.nfts = model.nfts
        completion(.success(model.nfts))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
