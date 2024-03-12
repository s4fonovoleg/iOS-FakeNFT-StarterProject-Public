//
//  CatalogCollection.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 16.02.2024.
//

import Foundation

struct CatalogCollection: Codable {
    let name: String
    let nfts: [String]
    let cover: String
    let id: String
    let description: String
    let author: String
}
