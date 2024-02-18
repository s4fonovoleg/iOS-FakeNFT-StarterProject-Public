import Foundation

final class CartViewModel {
  // MARK: - Properties:
  var onChange: (() -> Void)?
  var onChangeSort: (() -> Void)?
  var sortType = SortTypeStorage.sortType {
    didSet {
      onChangeSort?()
    }
  }
  var nfts: [NFTModel] = [] {
    didSet {
      onChange?()
    }
  }
  
  // MARK: - Private properties:
  private let service: CartServiceProtocol
  
  // MARK: - Methods:
  init(service: CartServiceProtocol = CartService()) {
    self.service = service
  }
  
  func updateOrder(with newNFTs: [String]) {
    service.updateOrder(with: newNFTs) { result in
      switch result {
      case .success:
        print("Заказ успешно обновлен")
      case .failure:
        print("Не удалось обновить заказ")
      }
      UIBlockingProgressHUD.hide()
    }
    loadNFTModels()
  }
  
  func loadNFTModels() {
    UIBlockingProgressHUD.show()
    service.loadOrder { result in
      switch result {
      case .success(let order):
        order.forEach { id in
          self.service.loadNft(by: id) { models in
            switch models {
            case .success(let model):
              self.nfts.append(model)
            case .failure(let error):
              print(error.localizedDescription)
            }
          }
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
      UIBlockingProgressHUD.hide()
    }
  }
}
