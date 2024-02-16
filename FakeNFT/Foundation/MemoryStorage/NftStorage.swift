import Foundation

protocol NftStorage: AnyObject {
    func saveNft(_ nft: NFTModel)
    func getNft(with id: String) -> NFTModel?
}

// Пример простого класса, который сохраняет данные из сети
final class NftStorageImpl: NftStorage {
    private var storage: [String: NFTModel] = [:]

    private let syncQueue = DispatchQueue(label: "sync-nft-queue")

    func saveNft(_ nft: NFTModel) {
        syncQueue.async { [weak self] in
            self?.storage[nft.id] = nft
        }
    }

    func getNft(with id: String) -> NFTModel? {
        syncQueue.sync {
            storage[id]
        }
    }
}
