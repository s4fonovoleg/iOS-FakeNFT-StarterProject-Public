import Foundation

struct GetOrderRequest: NetworkRequest {
  var httpMethod: HttpMethod = .get
  var endpoint: URL? {
    URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
  }
}
