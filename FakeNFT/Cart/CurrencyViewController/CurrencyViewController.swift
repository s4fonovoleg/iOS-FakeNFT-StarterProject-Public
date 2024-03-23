import Foundation
import UIKit

protocol SuccessfulPaymentViewControllerDelegate: AnyObject {
  func backButtonPressed()
}

final class CurrencyViewController: UIViewController, SuccessfulPaymentViewControllerDelegate {
  // MARK: - Private Properties:
  private let viewModel: CurrencyViewModelProtocol
  private var selectedIndexPath: IndexPath? {
    didSet {
      updatePayButtonCondition()
    }
  }
  private let geometricParams = GeometricParams(cellCount: 2, leftInset: 16, rightInset: 16, cellSpacing: 7)
  private lazy var paymentView: UIView = {
    let view = UIView()
    view.backgroundColor = Asset.CustomColors.ypLightGrey.color
    view.layer.cornerRadius = 12
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    
    return view
  }()
  
  private lazy var agreementLabel: UILabel = {
    let label = UILabel()
    label.textColor = Asset.CustomColors.ypBlack.color
    label.font = .caption2
    label.text = L10n.Localizable.Label.paymentAgreement
    label.textAlignment = .left
    
    return label
  }()
  
  private lazy var agreementButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .clear
    button.titleLabel?.font = .caption2
    button.setTitleColor(Asset.CustomColors.ypBlue.color, for: .normal)
    button.setTitle(L10n.Localizable.Button.paymentAgreementTitle, for: .normal)
    button.addTarget(self, action: #selector(agreementButtonPressed), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var payButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(L10n.Localizable.Button.payTitle, for: .normal)
    button.tintColor = Asset.CustomColors.ypWhite.color
    button.titleLabel?.font = .bodyBold
    button.backgroundColor = Asset.CustomColors.ypBlack.color
    button.layer.cornerRadius = 16
    button.layer.masksToBounds = true
    button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var currencyCollection: UICollectionView = {
    let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collection.delegate = self
    collection.dataSource = self
    collection.backgroundColor = .clear
    collection.allowsMultipleSelection = false
    collection.isScrollEnabled = false
    collection.showsHorizontalScrollIndicator = false
    collection.showsVerticalScrollIndicator = false
    collection.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CurrencyCollectionViewCell.reuseID)
    
    return collection
  }()
  
  // MARK: - Private methods:
  init(viewModel: CurrencyViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupNavBar() {
    if navigationController?.navigationBar != nil {
      title = L10n.Localizable.Label.choosePaymentTypeTitle
      let leftBarButton = UIBarButtonItem(image: Asset.CustomIcons.backButtonIcon.image, style: .plain, target: self, action: #selector(backButtonPressed))
      leftBarButton.tintColor = Asset.CustomColors.ypBlack.color
      navigationItem.leftBarButtonItem = leftBarButton
      navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
    }
  }
  
  private func setupLayout() {
    [currencyCollection, paymentView].forEach {
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
      currencyCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      currencyCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      currencyCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      currencyCollection.heightAnchor.constraint(equalToConstant: 230),
      
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
  
  private func loadCurrencies() {
    viewModel.loadCurrencies()
  }
  
  private func updatePayButtonCondition() {
    if selectedIndexPath != nil {
      payButton.isEnabled = true
    } else {
      payButton.isEnabled = false
    }
  }
  
  private func showSuccessfulPaymentView() {
    let viewToPresent = SuccessfulPaymentViewController()
    viewToPresent.delegate = self
    viewToPresent.modalPresentationStyle = .fullScreen
    viewToPresent.modalTransitionStyle = .crossDissolve
    self.present(viewToPresent, animated: true)
  }
  
  private func showFailedPaymentAlert() {
    AlertPresenter.showAlert(model: ModelOfError(message: L10n.Localizable.Label.paymentErrorTitle, actionText: L10n.Localizable.Button.tryAgainTitle, cancelText: L10n.Localizable.Button.cancelTitle, action: {
      self.payButtonTapped()
    }), controller: self)
  }
}

// MARK: - LifeCycle:
extension CurrencyViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.onChange = { [weak self] in
      guard let self else { return }
      self.currencyCollection.reloadData()
    }
    viewModel.onChangeLoader = { isLoading in
      isLoading ? UIBlockingProgressHUD.show() : UIBlockingProgressHUD.hide()
    }
    viewModel.onChangeSuccess = { [weak self] in
      guard let self else { return }
      self.showSuccessfulPaymentView()
    }
    viewModel.onChangeFail = { [weak self] in
      guard let self else { return }
      self.showFailedPaymentAlert()
    }
    self.view.backgroundColor = Asset.CustomColors.ypWhite.color
    setupNavBar()
    setupLayout()
    setupConstraints()
    loadCurrencies()
    updatePayButtonCondition()
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    currencyCollection.reloadData()
  }
}

// MARK: - Objc-Methods:
extension CurrencyViewController {
  @objc func backButtonPressed() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func agreementButtonPressed() {
    let viewToPresent = UserAgreementViewController(viewModel: UserAgreementViewModel())
    navigationController?.pushViewController(viewToPresent, animated: true)
  }
  
  @objc private func payButtonTapped() {
    guard let selectedIndexPath else { return }
    let currency = viewModel.currencies[selectedIndexPath.row]
    viewModel.makePayment(with: Int(currency.id) ?? 0)
  }
}

// MARK: - UICollectionViewDelegate:
extension CurrencyViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if selectedIndexPath == indexPath {
      selectedIndexPath = nil
    } else {
      selectedIndexPath = indexPath
    }
    collectionView.reloadData()
  }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension CurrencyViewController: UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let availableWidth = collectionView.frame.size.width - geometricParams.paddingWidth
    let cellWidth = availableWidth / CGFloat(geometricParams.cellCount)
    
    return CGSize(width: cellWidth, height: 46)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    geometricParams.cellSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    7
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    UIEdgeInsets(top: 20, left: geometricParams.leftInset, bottom: 0, right: geometricParams.rightInset)
  }
}

// MARK: - UICollectionViewDataSource:
extension CurrencyViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.currencies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let currency = viewModel.currencies[indexPath.row]
    let isSelected = selectedIndexPath == indexPath ? true : false
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.reuseID, for: indexPath) as? CurrencyCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.configureCell(currency)
    cell.layer.cornerRadius = 12
    cell.layer.masksToBounds = true
    cell.backgroundColor = Asset.CustomColors.ypLightGrey.color
    cell.layer.borderWidth = isSelected ? 1 : 0
    cell.layer.borderColor = isSelected ? Asset.CustomColors.ypBlack.color.cgColor : .none
    
    return cell
  }
}
