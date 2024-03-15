//
//  ProfileWebViewController.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 27.02.2024.
//

import UIKit
import WebKit

class ProfileWebViewController: UIViewController, WKUIDelegate {
    
    var userSite: String = "" {
        didSet {
            guard let url = URL(string: userSite) else { return }
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        view = webView
    }
}
