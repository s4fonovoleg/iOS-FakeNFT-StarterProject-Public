//
//  CatalogNftService.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 21.02.2024.
//

import Foundation

final class CatalogNftService {

    func loadNftColletion(compleition: @escaping (Result<CatalogCollection, Error>) -> Void, id: String) {
        var urlRequest = URLRequest(url: URL(string: RequestConstants.baseURL + "/api/v1/collections/\(id)")!)
        urlRequest.setValue(RequestConstants.token,
                            forHTTPHeaderField: "X-Practicum-Mobile-Token")
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error {
                DispatchQueue.main.async {
                    compleition(.failure(error))
                }
                return
            }
            guard let data else {
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let result = try? decoder.decode(CatalogCollection.self, from: data) {

                DispatchQueue.main.async {
                    compleition(.success(result))
                }
            }
        }.resume()
    }

    func loadNfts( nfts: [String], compleition: @escaping (Result<[Nft], Error>) -> Void) {
        let group = DispatchGroup()
        var nft = [Nft]()
        for id in nfts {
            var urlRequest = URLRequest(url: URL(string: RequestConstants.baseURL + "/api/v1/nft/\(id)")!)
            urlRequest.setValue(RequestConstants.token,
                                forHTTPHeaderField: "X-Practicum-Mobile-Token")
            group.enter()
            URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
                guard let data else {
                    group.leave()
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let result = try? decoder.decode(Nft.self, from: data) {
                    nft.append(result)
                }
                group.leave()
            }.resume()
        }
        group.notify(queue: .main) {
            compleition(.success(nft))
        }
    }
}
