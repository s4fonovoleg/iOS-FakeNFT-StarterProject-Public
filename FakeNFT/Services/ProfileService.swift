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
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient){
        self.networkClient = networkClient
    }
    
    func loadProfile(completion: @escaping ProfileCompletion){
        
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
