import Foundation

struct OrderStorage {
  // MARK: - Properties:
  @UserDefaultEncoded(key: "Order", default: nil) var order: OrderModel?
}
