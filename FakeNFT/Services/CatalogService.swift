//
//  CatalogService.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 15.02.2024.
//

import Foundation

final class CatalogService {
    
    func loadNftColletion(compleition : @escaping (Result<[CatalogCollection],Error>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: "https://d5dn3j2ouj72b0ejucbl.apigw.yandexcloud.net/api/v1/collections")!)
        urlRequest.setValue("d24aac83-291f-43db-926b-2e3e3cb3d154", forHTTPHeaderField: "X-Practicum-Mobile-Token")
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error {
                compleition(.failure(error))
                return
            }
            guard let data else {
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let resutl = try? decoder.decode([CatalogCollection].self, from: data) {
                DispatchQueue.main.async {
                    compleition(.success(resutl))
                }
            }
        }.resume()
    }
    
}

