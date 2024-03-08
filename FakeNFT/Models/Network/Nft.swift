import Foundation

struct Nft: Decodable {
    let name: String
    let images: [String]
    let rating: Int
    let price: Float
    let author: String
    let id: String
}
