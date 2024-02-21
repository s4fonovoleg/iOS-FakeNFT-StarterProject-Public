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
            if let resutl = try? decoder.decode(CatalogCollection.self, from: data) {
                DispatchQueue.main.async {
                    compleition(.success(resutl))
                }
            }
        }.resume()
    }
}
