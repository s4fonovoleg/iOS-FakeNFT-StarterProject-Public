//
//  AboutAuthorView.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 04.03.2024.
//

import UIKit
import ProgressHUD
import WebKit

final class AboutAuthorView: UIViewController {

    private var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        setupScreen()
        ProgressHUD.show()
        loadWebPage()
    }

    private func setupScreen() {
        view.backgroundColor = UIColor(named: "WhiteColor")
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.left.right.bottom.top.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func loadWebPage() {
        guard let url = URL(string: "https://practicum.yandex.ru/ios-developer") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension AboutAuthorView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressHUD.dismiss()
    }
}
