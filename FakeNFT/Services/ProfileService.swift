//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 28.02.2024.
//

import Foundation

typealias ProfileCompletion = (Result<Profile, Error>) -> Void

protocol ProfileServiceProtocol {
    
    func loadProfile(completion: @escaping ProfileCompletion)
    func saveProfile(_ profile: String, completion: @escaping ProfileCompletion)
}

final class ProfileService: ProfileServiceProtocol {
    
    // TODO: Убрать статичное свойство после того как в профиле появятся реальные данные
    static let mockNFTsData: [String] = [
        "d6a02bd1-1255-46cd-815b-656174c1d9c0",
        "b2f44171-7dcd-46d7-a6d3-e2109aacf520",
        "594aaf01-5962-4ab7-a6b5-470ea37beb93",
        "9e472edf-ed51-4901-8cfc-8eb3f617519f",
        "a4edeccd-ad7c-4c7f-b09e-6edec02a812b",
        "2c9d09f6-25ac-4d6f-8d6a-175c4de2b42f"
    ]
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadProfile(completion: @escaping ProfileCompletion) {
        
        let request = ProfileGetRequest()
        
        networkClient.send(request: request, type: Profile.self) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveProfile(_ profile: String, completion: @escaping ProfileCompletion) {
        
        let request = ProfilePutRequest(urlencoded: profile)
        
        networkClient.send(request: request, type: Profile.self) { result in
            
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
