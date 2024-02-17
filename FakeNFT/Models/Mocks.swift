import Foundation
import UIKit

struct NFTMocks {
  static var nfts: [NFTModel] = [
    NFTModel(name: "Zeus", images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png")!], rating: 3, price: 4.75, id: "af42ff3"),
    NFTModel(name: "Cratos", images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Peach/Nacho/1.png")!], rating: 2, price: 12.23, id: "a2ff3"),
    NFTModel(name: "Apollon", images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Blue/Bonnie/2.png")!], rating: 1, price: 6, id: "af423")
  ]
}
