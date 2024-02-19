import Foundation

struct PutOrderRequest: NetworkRequest {
  var httpMethod: HttpMethod 
  var dto: Encodable?
  var endpoint: URL? {
    URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
  }
}