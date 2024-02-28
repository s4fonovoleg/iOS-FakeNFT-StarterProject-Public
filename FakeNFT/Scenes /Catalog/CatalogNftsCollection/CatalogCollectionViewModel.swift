//
//  CatalogCollectionViewModel.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 21.02.2024.
//

import Foundation

final class CatalogCollectionViewModel {

    var id: String?

    private(set) var imageURL: URL? {
        didSet {
            imageChange?()
        }
    }

    private(set) var nameOfNFTCollection: String? {
        didSet {
            nameOfNFTCollectionChange?()
        }
    }

    private(set) var nameOfAuthor: String? {
        didSet {
            nameOfAuthorChange?()
        }
    }

    private(set) var nftDescription: String? {
        didSet {
            descriptionChange?()
        }
    }

    private(set) var colletotionData = [Nft]() {
         didSet {
             collectionChange?()
         }
     }

    var descriptionChange: (() -> Void)?

    var nameOfNFTCollectionChange: (() -> Void)?

    var imageChange: (() -> Void)?

    var collectionChange: (() -> Void)?

    var showError: (() -> Void)?

    var nameOfAuthorChange: (() -> Void)?

    private var service = CatalogNftService()

    func loadNft() {
        guard let id else {
            return
        }
        service.loadNftColletion(compleition: { result in
            switch result {
            case .success(let res):
                self.imageURL = URL(string: res.cover)
                self.nameOfNFTCollection = "\(res.name.first!.uppercased())" +
                res.name.suffix(res.name.count - 1)
                self.nameOfAuthor = res.author
                self.nftDescription = res.description
                self.service.loadNfts(nfts: res.nfts) { result in
                    switch result {
                    case .success(let nft):
                        self.colletotionData = nft
                    case .failure(_):
                        print(0)
                    }
                }
            case .failure(_):
                self.showError?()
            }}, id: id)
    }

}
