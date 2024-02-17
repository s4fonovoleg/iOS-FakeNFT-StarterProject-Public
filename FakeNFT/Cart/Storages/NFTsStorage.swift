import Foundation

struct NFTsStorage {
  // MARK: - Properties:
  @UserDefaultEncoded(key: "NFTS") static var nfts: [String]
}
