import Foundation

final class CartViewModel {
  // MARK: - Properties:
  var onChange: (()-> Void)?
  var nfts: [NftModel] = [] {
    didSet {
      onChange?()
    }
  }
  
  // MARK: - Private properties:
  private let model: CartServiceProtocol
  
  // MARK: - Methods:
  init(model: CartServiceProtocol = CartService()) {
    self.model = model
  }
  
  func loadNft(by id: String) {
    model.loadNft(id: id) { result in
      switch result {
      case .success(let model):
        self.nfts.append(model)
      case .failure(_):
        <#code#>
      }
    }
  }
  
  func updateOrder(of nfts: [String]) {
    model.updateOrder(with: nfts) { result in
      switch result {
      case .success(<#T##[String]#>)
      }
    }
  }
}
