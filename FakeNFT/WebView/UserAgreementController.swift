import Foundation
import UIKit
import WebKit

final class UserAgreementViewController: UIViewController {
  // MARK: - Private Properties:
  private let url = URL(string: RequestConstants.paymentAgreement)
  private lazy var webView: WKWebView = {
    let web = WKWebView()
    
    return web
  }()
  
  // MARK: - Private Methods:
  private func setupNavBar() {
    if navigationController?.navigationBar != nil {
      title = L10n.Localizable.Label.paymentAgreementTitle
      let leftBarButton = UIBarButtonItem(image: UIImage(named: "backButtonIcon"), style: .plain, target: self, action: #selector(backButtonPressed))
      navigationItem.leftBarButtonItem = leftBarButton
      navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
    }
  }
  
  private func loadWebView() {
    guard let url else { return }
    let request = URLRequest(url: url)
    webView.load(request)
  }
  
  private func setupUI() {
    setupNavBar()
    loadWebView()
    webView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(webView)
    
    NSLayoutConstraint.activate([
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - LifeCycle:
extension UserAgreementViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
}

// MARK: - Objc-Methods:
extension UserAgreementViewController {
  @objc private func backButtonPressed() {
    navigationController?.popViewController(animated: true)
  }
}
