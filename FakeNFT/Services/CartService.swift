import Foundation

typealias NftCompletion = (Result<Nft, Error>) -> Void
typealias NFTsCompletion = (Result<[String], Error>) -> Void

protocol CartServiceProtocol {
  func loadNft(id: String, completion: @escaping NftCompletion)
  func loadOrder(completion: @escaping NFTsCompletion)
}

final class CartService: CartServiceProtocol {
  // MARK: - Private Properties:
  private let networkClient: NetworkClient
  private let storage: NftStorage

  
  // MARK: - Methods:
  init(
    networkClient: NetworkClient = DefaultNetworkClient(),
    storage: NftStorage) {
      self.storage = storage
      self.networkClient = networkClient
    }
  
  func loadNft(id: String, completion: @escaping NftCompletion) {
    if let nft = storage.getNft(with: id) {
      completion(.success(nft))
      return
    }
    
    let request = NFTRequest(id: id)
    networkClient.send(request: request, type: Nft.self) { [weak storage] result in
      switch result {
      case .success(let nft):
        storage?.saveNft(nft)
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
    let request = putOrderRequest(
      httpMethod: .put,
      dto: nfts)
    networkClient.send(request: request) { result in
      switch result {
      case .success(let data):
        print(data)
      case .failure(let error):
        
      }
    }
  }
}
