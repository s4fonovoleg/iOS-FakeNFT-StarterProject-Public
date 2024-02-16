import Foundation
import UIKit

struct NftModel: Codable {
  let name: String
  let images: [URL]
  let rating: Int
  let price: String
  let id: String
}
