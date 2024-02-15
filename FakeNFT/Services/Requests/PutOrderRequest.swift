import Foundation

import Foundation

struct putOrderRequest: NetworkRequest {
  var httpMethod: HttpMethod 
  var dto: Encodable?
  var endpoint: URL? {
    URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
  }
}
