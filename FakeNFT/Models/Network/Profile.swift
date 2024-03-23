//
//  Profile.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 28.02.2024.
//

import Foundation

struct Profile: Codable {
    let avatar: String?
    let description: String?
    let id: String?
    let likes: [String]?
    let name: String?
    let nfts: [String]?
    let website: String?
}
