import Foundation
import UIKit

struct Nft: Decodable {
    let id: String
    let images: [URL]
}

struct NFTModel {
  let id: UUID
  let name: String
  let image: UIImage
  let price: String
}
