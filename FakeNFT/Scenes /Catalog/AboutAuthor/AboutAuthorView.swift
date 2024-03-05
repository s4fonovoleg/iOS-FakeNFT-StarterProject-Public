//
//  AboutAuthorView.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 04.03.2024.
//

import UIKit
import WebKit

final class AboutAuthorView: UIViewController {

    var url: String?

    private var webView = WKWebView()

    private var viewModel = AboutAuthorViewModel()

    private var progressView = UIProgressView()

    private lazy var backButton: UIButton = {
        var button = UIButton()
        button.tintColor = UIColor(named: "BlackColor")
        button.setImage(UIImage(named: "BackButton"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        webView.navigationDelegate = self
        setupScreen()
        bind()
        if let url {
            viewModel.setUrl(stringUrl: url)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    private func setupScreen() {
        view.backgroundColor = UIColor(named: "WhiteColor")
        view.addSubview(webView)
        view.addSubview(backButton)
        view.addSubview(progressView)
        webView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        backButton.snp.makeConstraints {
            $0.height.width.equalTo(30)
            $0.left.equalToSuperview().offset(3)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(4)
        }
        progressView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(backButton.snp.bottom)
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

    @objc
    private func tapBackButton() {
        navigationController?.popViewController(animated: true)
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
