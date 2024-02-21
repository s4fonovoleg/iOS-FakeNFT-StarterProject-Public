import Foundation
import UIKit

final class CurrencyViewController: UIViewController {
  // MARK: - Private Properties:
  private lazy var paymentView: UIView = {
    let view = UIView()
    view.backgroundColor = .YPLightGrey
    view.layer.cornerRadius = 12
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    
    return view
  }()
  
  private lazy var agreementLabel: UILabel = {
    let label = UILabel()
    label.textColor = .YPBlack
    label.font = .caption2
    label.text = L10n.Localizable.Label.paymentAgreement
    label.textAlignment = .left
    
    return label
  }()
  
  private lazy var agreementButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .clear
    button.titleLabel?.font = .caption2
    button.setTitleColor(.YPBlue, for: .normal)
    button.setTitle(L10n.Localizable.Button.paymentAgreementTitle, for: .normal)
    
    return button
  }()
  
  private lazy var payButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(L10n.Localizable.Button.payTitle, for: .normal)
    button.tintColor = .YPWhite
    button.titleLabel?.font = .bodyBold
    button.backgroundColor = .YPBlack
    button.layer.cornerRadius = 16
    button.layer.masksToBounds = true
    
    return button
  }()
  // MARK: - Private methods:
  private func setupNavBar() {
    if navigationController?.navigationBar != nil {
      title = L10n.Localizable.Label.choosePaymentTypeTitle
      let leftBarButton = UIBarButtonItem(image: UIImage(named: "backButtonIcon"), style: .plain, target: self, action: #selector(backButtonPressed))
      navigationItem.leftBarButtonItem = leftBarButton
      navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
    }
  }
  
  private func setupLayout() {
    [paymentView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    [agreementLabel, agreementButton, payButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      paymentView.addSubview($0)
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      paymentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      paymentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      paymentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      paymentView.heightAnchor.constraint(equalToConstant: 186),
      
      agreementLabel.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 16),
      agreementLabel.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -16),
      agreementLabel.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 16),
      agreementLabel.heightAnchor.constraint(equalToConstant: 18),
      
      agreementButton.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 16),
      agreementButton.topAnchor.constraint(equalTo: agreementLabel.bottomAnchor, constant: 4),
      agreementButton.heightAnchor.constraint(equalToConstant: 18),
      
      payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      payButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      payButton.heightAnchor.constraint(equalToConstant: 60),
      payButton.topAnchor.constraint(equalTo: agreementButton.bottomAnchor, constant: 20)
    ])
  }
}

// MARK: - LifeCycle:
extension CurrencyViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .YPWhite
    setupNavBar()
    setupLayout()
    setupConstraints()
  }
}

// MARK: - Objc-Methods:
extension CurrencyViewController {
  @objc private func backButtonPressed() {
    navigationController?.popViewController(animated: true)
  }
}
