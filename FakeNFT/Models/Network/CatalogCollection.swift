//
//  CatalogCollection.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 16.02.2024.
//

import Foundation

struct CatalogCollection: Codable {
    var name: String
    var nfts: [String]
    var cover: String
    var id: String
    var description: String
    var author: String
}
