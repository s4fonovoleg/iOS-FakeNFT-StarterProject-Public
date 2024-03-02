//
//  FormUrlencoding.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 02.03.2024.
//

import Foundation

enum Urlencoding {

    static func urlEncoded(formDataSet: [(String, String)]) -> String {
        return formDataSet.map { (key, value) in
            return escape(key) + "=" + escape(value)
        }.joined(separator: "&")
    }

    private static func escape(_ str: String) -> String {
        return str.replacingOccurrences(of: "\n", with: "\r\n")
            .addingPercentEncoding(withAllowedCharacters: sAllowedCharacters)!
            .replacingOccurrences(of: " ", with: "+")
    }

    private static let sAllowedCharacters: CharacterSet = {
        var allowed = CharacterSet.urlQueryAllowed
        allowed.insert(" ")
        allowed.remove("+")
        allowed.remove("/")
        allowed.remove("?")
        return allowed
    }()
}
