//
//  ProfileSaveRequest.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 02.03.2024.
//

import Foundation

struct ProfilePutRequest: NetworkRequest {
    
    let urlencoded: String?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
    
    var httpMethod: HttpMethod {
        .put
    }
}
