//
//  AboutAuthorView.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 12.03.2024.
//

import UIKit
import SnapKit
import WebKit

final class AboutAuthorView: UIViewController {

    var url: String?

    private var webView = WKWebView()

    private var viewModel = AboutAuthorViewModel()

    private var progressView = UIProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        webView.navigationDelegate = self
        setupScreen()
        bind()
        if let url {
            viewModel.setUrl(stringUrl: url)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.isTranslucent = false
    }

    private func setupScreen() {
        view.backgroundColor = UIColor(named: "WhiteColor")
        view.addSubview(webView)
        view.addSubview(progressView)
        webView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }

        progressView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(2)
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
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if webView.estimatedProgress < 1 {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.progress = 1
        progressView.isHidden = true
    }
}

extension AboutAuthorView: ErrorView {}
