import Foundation

struct NFTModel: Decodable {
    let name: String
    let images: [URL]
    let rating: Int
    let price: Float
    let author: String
    let id: String
}
