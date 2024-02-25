import Foundation
import UIKit

final class SuccessfulPaymentViewController: UIViewController {
  // MARK: - Properties:
  weak var delegate: SuccessfulPaymentViewControllerDelegate?
  // MARK: - Privatre Properties:
  private lazy var successImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFill
    imageView.image = Asset.CustomImages.successPayment.image
    
    return imageView
  }()
  
  private lazy var successPaymentLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.textAlignment = .center
    label.textColor = Asset.CustomColors.ypBlack.color
    label.font = .headline3
    label.text = L10n.Localizable.Label.successPaymentTitle
    
    return label
  }()
  
  private lazy var backToCatalogButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(L10n.Localizable.Button.backToCatalogTitle, for: .normal)
    button.backgroundColor = Asset.CustomColors.ypBlack.color
    button.setTitleColor(Asset.CustomColors.ypWhite.color, for: .normal)
    button.layer.cornerRadius = 16
    button.layer.masksToBounds = true
    button.addTarget(self, action: #selector(backToCatalogButtonPressed), for: .touchUpInside)
    
    return button
  }()
  
  // MARK: - Private Methods:
  private func setupLayout() {
    [successImageView, successPaymentLabel, backToCatalogButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      successImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 196),
      successImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      successImageView.widthAnchor.constraint(equalToConstant: 278),
      successImageView.heightAnchor.constraint(equalToConstant: 278),
      
      successPaymentLabel.topAnchor.constraint(equalTo: successImageView.bottomAnchor, constant: 20),
      successPaymentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
      successPaymentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
      successPaymentLabel.heightAnchor.constraint(equalToConstant: 56),
      
      backToCatalogButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
      backToCatalogButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      backToCatalogButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      backToCatalogButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}

// MARK: - LifeCycle:
extension SuccessfulPaymentViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = Asset.CustomColors.ypWhite.color
    setupLayout()
    setupConstraints()
  }
}

// MARK: - Objc-Methods:
extension SuccessfulPaymentViewController {
  @objc private func backToCatalogButtonPressed() {
    if let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}),
       let tabBarController = window.rootViewController as? UITabBarController {
      DispatchQueue.main.async {
        tabBarController.selectedIndex = 1
      }
      self.dismiss(animated: true)
      delegate?.backButtonPressed()
    }
  }
}
