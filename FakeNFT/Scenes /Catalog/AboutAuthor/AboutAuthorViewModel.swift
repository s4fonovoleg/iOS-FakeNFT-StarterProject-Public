//
//  AboutAuthorViewModel.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 12.03.2024.
//

import Foundation

final class AboutAuthorViewModel {

   private(set) var authorUrl: String? {
        didSet {
            loadWebView?()
        }
    }

    func setUrl(stringUrl: String) {
        authorUrl = stringUrl
    }

    var loadWebView: (() -> Void)?

}
