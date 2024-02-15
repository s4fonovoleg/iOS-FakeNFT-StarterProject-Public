import Foundation

struct PaymentModel: Decodable {
  let success: Bool
  let orderId: String
  let id: String
}
