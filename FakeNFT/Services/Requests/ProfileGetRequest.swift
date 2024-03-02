//
//  ProfileRequest.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 29.02.2024.
//

import Foundation

struct ProfileGetRequest: NetworkRequest {

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
}
