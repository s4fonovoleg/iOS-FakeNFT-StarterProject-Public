import Foundation
import UIKit
import WebKit

final class UserAgreementViewController: UIViewController {
  // MARK: - Private Properties:
  private let viewModel: UserAgreementViewModelProtocol
  private var estimatedProgressObservation: NSKeyValueObservation?
  private let url = URL(string: RequestConstants.paymentAgreement)
  private lazy var webView: WKWebView = {
    let web = WKWebView()
    
    return web
  }()
  
  private lazy var progressView: UIProgressView = {
    let progress = UIProgressView()
    progress.progressTintColor = Asset.CustomColors.ypBlackAndBlue.color
    progress.progressViewStyle = .bar
    progress.trackTintColor = Asset.CustomColors.ypWhiteUniversal.color
    
    return progress
  }()
  
  // MARK: - Private Methods:
  init(viewModel: UserAgreementViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupNavBar() {
    if navigationController?.navigationBar != nil {
      title = L10n.Localizable.Label.paymentAgreementTitle
      let leftBarButton = UIBarButtonItem(image: Asset.CustomIcons.backButtonIcon.image, style: .plain, target: self, action: #selector(backButtonPressed))
      leftBarButton.tintColor = Asset.CustomColors.ypBlack.color
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
    webView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(webView)
    
    progressView.translatesAutoresizingMaskIntoConstraints = false
    webView.addSubview(progressView)
    
    NSLayoutConstraint.activate([
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      progressView.topAnchor.constraint(equalTo: webView.topAnchor),
      progressView.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
      progressView.trailingAnchor.constraint(equalTo: webView.trailingAnchor)
    ])
  }
  
  private func addEstimatedProgressObservation() {
    estimatedProgressObservation = webView.observe(
      \.estimatedProgress,
       options: .new,
       changeHandler: { [weak self] _, _ in
         guard let self else { return }
         self.viewModel.updateProgressView(webView.estimatedProgress)
       })
  }
  
  func setProgressValue(_ newValue: Float) {
    progressView.progress = newValue
  }
  
  func progressViewIsHidden(_ isHidden: Bool) {
    progressView.isHidden = isHidden
  }
}

// MARK: - LifeCycle:
extension UserAgreementViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.onChangeProgress = { [weak self] value in
      guard let self else { return }
      self.setProgressValue(value)
    }
    viewModel.onChangeVisibility = { [weak self] isHidden in
      guard let self else { return }
      self.progressViewIsHidden(isHidden)
    }
    
    addEstimatedProgressObservation()
    loadWebView()
    setupNavBar()
    setupUI()
  }
}

// MARK: - Objc-Methods:
extension UserAgreementViewController {
  @objc private func backButtonPressed() {
    navigationController?.popViewController(animated: true)
  }
}
