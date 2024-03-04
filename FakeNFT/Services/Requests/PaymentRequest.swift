import Foundation

struct PaymentRequest: NetworkRequest {
  var httpMethod: HttpMethod = .get
  var currencyId: Int
  var endpoint: URL? {
    URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1/payment/\(currencyId)")
  }
}
