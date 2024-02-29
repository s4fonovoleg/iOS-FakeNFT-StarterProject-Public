//
//  CatalogCollectionViewModel.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 21.02.2024.
//

import Foundation

final class CatalogCollectionViewModel {

    var id: String?

    private(set) var cartCollection = [String]()

    private(set) var likesCollection = [String]()

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

    private var serviceNft = ServiceNft()

    func loadNft() {
        guard let id else {
            return
        }
        service.loadNftColletion(compleition: { result in
            self.serviceNft.loadOrderId {
                self.cartCollection = $0
            }
            self.serviceNft.loadLikes {
                self.likesCollection = $0
            }
            switch result {
            case .success(let res):
                self.service.loadNfts(nfts: res.nfts) { result in
                    switch result {
                    case .success(let nft):
                        self.colletotionData = nft
                        self.imageURL = URL(string: res.cover)
                        self.nameOfNFTCollection = "\(res.name.first!.uppercased())" +
                        res.name.suffix(res.name.count - 1)
                        self.nameOfAuthor = res.author
                        self.nftDescription = res.description
                    case .failure(_):
                        print(0)
                    }
                }
            case .failure(_):
                self.showError?()
            }}, id: id)
    }

    func putNft(id: String) {
        if cartCollection.contains(id) {
            cartCollection.removeAll {
                $0 == id
            }
        } else {
            self.cartCollection.append(id)
        }
        serviceNft.putToCart(id: cartCollection)
    }

    func putLikes(id: String) {
        if likesCollection.contains(id) {
            likesCollection.removeAll {
                $0 == id
            }
        } else {
            self.likesCollection.append(id)
        }
        serviceNft.putToFavorite(id: likesCollection)
    }

}
