import Foundation

protocol CartViewModelProtocol: AnyObject {
  var nfts: [NFTModel] { get }
  var sortType: SortType { get set }
  var onChange: (() -> Void)? { get set }
  var isLoading: ((Bool) -> Void)? { get set }
  func updateOrder()
  func loadNFTModels()
  func removeModel(_ model: NFTModel)
  func sort(by type: SortType)
}

final class CartViewModel: CartViewModelProtocol {
  // MARK: - Properties:
  var onChange: (() -> Void)?
  var isLoading: ((Bool) -> Void)?
  var sortType = SortTypeStorage.sortType
  var nfts: [NFTModel] = [] {
    didSet {
      onChange?()
    }
  }
  
  // MARK: - Private properties:
  private let service: CartServiceProtocol
  
  // MARK: - Methods:
  init(service: CartServiceProtocol) {
    self.service = service
  }
  
  func updateOrder() {
    let nftsId = nfts.map { $0.id }
    service.updateOrder(with: nftsId) { result in
      switch result {
      case .success:
        print("Заказ успешно обновлен")
      case .failure:
        print("Не удалось обновить заказ")
      }
      self.isLoading?(false)
    }
  }
  
  func loadNFTModels() {
    isLoading?(true)
    let dispatchGroup = DispatchGroup()
    var loadedNfts: [NFTModel] = []
    
    service.loadOrder { result in
      switch result {
      case .success(let order):
        for id in order {
          dispatchGroup.enter()
          self.service.loadNft(by: id) { models in
            switch models {
            case .success(let model):
              loadedNfts.append(model)
            case .failure(let error):
              print(error.localizedDescription)
            }
            dispatchGroup.leave()
          }
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
      dispatchGroup.notify(queue: .main) {
        let sortedArray = self.sortArray(loadedNfts)
        self.nfts = sortedArray
        self.isLoading?(false)
      }
    }
  }
  
  private func sortArray(_ array: [NFTModel]) -> [NFTModel] {
    var sortedArray = array
    switch sortType {
    case .byPrice:
      sortedArray.sort { $0.price > $1.price }
    case .byRating:
      sortedArray.sort { $0.rating > $1.rating }
    case .byName:
      sortedArray.sort { $0.name < $1.name }
    }
    return sortedArray
  }
  
  func sort(by type: SortType) {
    sortType = type
    SortTypeStorage.sortType = type
    switch sortType {
    case .byPrice:
      nfts.sort { $0.price > $1.price }
    case .byRating:
      nfts.sort { $0.rating > $1.rating }
    case .byName:
      nfts.sort { $0.name < $1.name }
    }
  }
  
  func removeModel(_ model: NFTModel) {
    if let index = nfts.firstIndex(where: { $0.id == model.id }) {
      nfts.remove(at: index)
      updateOrder()
    }
  }
}
