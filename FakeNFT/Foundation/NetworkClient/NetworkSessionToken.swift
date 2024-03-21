//
//  NetworkSessionToken.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 29.02.2024.
//

import Foundation

final class NetworkSessionToken {
    
    static let shared: NetworkSessionToken = NetworkSessionToken()
    
    private var sessionToken: String?
    
    var token: String? {
        get {
            return sessionToken
        }
        set {
            sessionToken = newValue
        }
    }
    
    private init() {}
    
    func clear() {
       sessionToken = nil
    }
}
