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

    private var viewModel = AboutAuthorViewModel()

    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        setupScreen()
        bind()
        if let url {
            viewModel.setUrl(stringUrl: url)
        }
    }

    private func setupScreen() {
        view.backgroundColor = UIColor(named: "WhiteColor")
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.left.right.bottom.top.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func bind() {
        viewModel.loadWebView = {
            // тут должна быть url но так как она не рабочая пока это
            guard let url = URL(string: "https://practicum.yandex.ru/ios-developer") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
}

extension AboutAuthorView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.isLoading {
            ProgressHUD.show()
        } else {
            ProgressHUD.dismiss()
        }
    }
}

extension AboutAuthorView: ErrorView {}