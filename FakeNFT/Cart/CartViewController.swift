import UIKit

class CartViewController: UIViewController {
  // MARK: - Properties:
  
  // MARK: - Properties properties:
  private var nftsCount: Int?
  private var totalCost: Float?
  private var viewModel: CartViewModelProtocol
  
  private lazy var refreshControl: UIRefreshControl = {
    let control = UIRefreshControl()
    control.addTarget(self, action: #selector(refresh), for: .valueChanged)
    
    return control
  }()
  
  private lazy var nftTable: UITableView = {
    let table = UITableView()
    table.delegate = self
    table.dataSource = self
    table.backgroundColor = .clear
    table.separatorStyle = .none
    table.allowsSelection = false
    table.register(NFTTAbleViewCell.self, forCellReuseIdentifier: NFTTAbleViewCell.reuseID)
    
    return table
  }()
  
  private lazy var paymentView: UIView = {
    let paymentView = UIView()
    paymentView.backgroundColor = .YPLightGrey
    paymentView.layer.cornerRadius = 16
    paymentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    paymentView.layer.masksToBounds = true
    paymentView.alpha = 0
    
    return paymentView
  }()
  
  private lazy var payButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(L10n.Localizable.Button.proceedToPayment, for: .normal)
    button.titleLabel?.font = .bodyBold
    button.setTitleColor(.YPWhite, for: .normal)
    button.backgroundColor = .YPBlack
    button.layer.cornerRadius = 16
    button.layer.masksToBounds = true
    
    return button
  }()
  
  private lazy var nftCountLabel: UILabel = {
    let label = UILabel()
    label.font = .caption1
    label.textColor = .YPBlack
    label.textAlignment = .left
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var totalCostLabel: UILabel = {
    let label = UILabel()
    label.font = .bodyBold
    label.textColor = .YPGreen
    label.textAlignment = .left
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var emptyCartLabel: UILabel = {
    let label = UILabel()
    label.font = .bodyBold
    label.textColor = .YPBlack
    label.numberOfLines = 1
    label.textAlignment = .center
    label.text = L10n.Localizable.Label.emptyCartTitle
    
    return label
  }()
  
  // MARK: - Private Methods:
  init(viewModel: CartViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func navBarSetup() {
    if (navigationController?.navigationBar) != nil {
      let rightButton = UIBarButtonItem(image: UIImage(named: "sortIcon"), style: .plain, target: self, action: #selector(sortButtonTapped))
      navigationItem.rightBarButtonItem = rightButton
    }
  }
  
  private func setupIU() {
    [emptyCartLabel, nftTable, paymentView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    [payButton, nftCountLabel, totalCostLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      paymentView.addSubview($0)
    }
    refreshControl.translatesAutoresizingMaskIntoConstraints = false
    nftTable.addSubview(refreshControl)
    
    NSLayoutConstraint.activate([
      nftTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      nftTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      nftTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      nftTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      paymentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      paymentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      paymentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      paymentView.heightAnchor.constraint(equalToConstant: 76),
      
      payButton.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -16),
      payButton.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 119),
      payButton.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 16),
      payButton.bottomAnchor.constraint(equalTo: paymentView.bottomAnchor, constant: -16),
      
      nftCountLabel.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 16),
      nftCountLabel.trailingAnchor.constraint(equalTo: payButton.leadingAnchor, constant: -61),
      nftCountLabel.bottomAnchor.constraint(equalTo: paymentView.bottomAnchor, constant: -40),
      nftCountLabel.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 16),
      
      totalCostLabel.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 16),
      totalCostLabel.widthAnchor.constraint(equalToConstant: 90),
      totalCostLabel.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 38),
      totalCostLabel.bottomAnchor.constraint(equalTo: paymentView.bottomAnchor, constant: -16),
      
      emptyCartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      emptyCartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      emptyCartLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      emptyCartLabel.heightAnchor.constraint(equalToConstant: 25)
    ])
  }
  
  private func updateNFTTableAnimatedly(with indexes: [Int: Int]) {
    UIBlockingProgressHUD.show()
    nftTable.performBatchUpdates({
      for (newIndex, oldIndex) in indexes {
        let oldIndexPath = IndexPath(row: oldIndex, section: 0)
        let newIndexPath = IndexPath(row: newIndex, section: 0)
        if oldIndexPath != newIndexPath {
          nftTable.moveRow(at: oldIndexPath, to: newIndexPath)
        }
      }
    }, completion: { _ in
      UIBlockingProgressHUD.hide()
    })
  }
  
  private func updatePaymentLabels() {
    let animation = CATransition()
    animation.duration = 0.5
    animation.type = .moveIn
    totalCostLabel.layer.add(animation, forKey: "Cost")
    nftCountLabel.layer.add(animation, forKey: "Count")
    totalCost = viewModel.nfts.compactMap { $0.price }.reduce(0, +)
    nftsCount = viewModel.nfts.count
    totalCostLabel.text = "\(totalCost ?? 0) ETH"
    nftCountLabel.text = "\(nftsCount ?? 0) NFT"
  }
  
  private func showOrHideEmptyCartLabel() {
    emptyCartLabel.isHidden = viewModel.nfts.isEmpty ? false : true
  }
  
  private func updateSortButtonCondition() {
    if (navigationController?.navigationBar) != nil {
      navigationItem.rightBarButtonItem?.isEnabled = viewModel.nfts.isEmpty ? false : true
    }
  }
  
  private func showOrHidePaymentInfo() {
    UIView.animate(withDuration: 0.25) {
      self.paymentView.alpha = self.viewModel.nfts.isEmpty ? 0 : 1
    }
  }
  
  private func updateUIElements() {
    nftTable.reloadData()
    updatePaymentLabels()
    showOrHideEmptyCartLabel()
    updateSortButtonCondition()
    showOrHidePaymentInfo()
  }
}

// MARK: - LifeCycle:
extension CartViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navBarSetup()
    setupIU()
    viewModel.onChange = { [weak self] in
      guard let self else { return }
      updateUIElements()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.loadNFTModels()
  }
}

// MARK: - Objc-Methods:
extension CartViewController {
  @objc private func sortButtonTapped() {
    SortingAlertPresenter.showAlert(
      model: SortingAlertModel(
        title: L10n.Localizable.Label.sortingTitle,
        message: nil,
        firstButtonText: SortType.byPrice.name,
        secondButtonText: SortType.byRating.name,
        thirdButtonText: SortType.byName.name,
        fourthButtonText: L10n.Localizable.Button.closeButtonTitle,
        firstCompletion: {
          self.viewModel.sortType = .byPrice
          SortTypeStorage.sortType = .byPrice
          self.viewModel.sort()
        },
        secondCompletion: {
          self.viewModel.sortType = .byRating
          SortTypeStorage.sortType = .byRating
          self.viewModel.sort()
        },
        thirdCompletion: {
          self.viewModel.sortType = .byName
          SortTypeStorage.sortType = .byName
          self.viewModel.sort()
        }), controller: self)
  }
  
  @objc private func refresh() {
    DispatchQueue.main.async {
      self.viewModel.loadNFTModels()
      self.refreshControl.endRefreshing()
    }
  }
}

// MARK: - UITableViewDelegate:
extension CartViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    140
  }
}

// MARK: - UITableViewDataSource:
extension CartViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.nfts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let nft = viewModel.nfts[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NFTTAbleViewCell.reuseID, for: indexPath) as? NFTTAbleViewCell else {
      return UITableViewCell()
    }
    cell.configureCell(for: nft)
    cell.delegate = self
    
    return cell
  }
}

// MARK: - nftTableViewCellDelegate:
extension CartViewController: NFTTableViewCellDelegate {
  func deleteButtopnPressed(on model: NFTModel) {
    let viewToPresent = DeleteNftViewController(delegate: self, modelTodelete: model)
    viewToPresent.modalPresentationStyle = .overFullScreen
    viewToPresent.modalTransitionStyle = .crossDissolve
    viewToPresent.modalPresentationCapturesStatusBarAppearance = true
    self.present(viewToPresent, animated: true)
  }
}

// MARK: - DeleteNFTViewControllerDelegate
extension CartViewController: DeleteNFTViewControllerDelegate {
  func removeNFT(model: NFTModel) {
    UIBlockingProgressHUD.show()
    viewModel.removeModel(model)
  }
}
