import UIKit

class CartViewController: UIViewController {
  // MARK: - Properties:
  
  // MARK: - Properties properties:
  private var nfts: [NFTModel] = NFTMocks.nfts
  private var nftsCount: Int?
  private var totalCost: Double?
  private var sortingAlertPresenter: SortingAlertPresenterProtocol?
  private let viewModel = CartViewModel()
  private var sortType = SortTypeStorage.sortType {
    didSet {
      updateNFTTableAnimatedly()
    }
  }
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
    label.text = "\(nftsCount ?? 0) NFT"
    
    return label
  }()
  
  private lazy var totalCostLabel: UILabel = {
    let label = UILabel()
    label.font = .bodyBold
    label.textColor = .YPGreen
    label.textAlignment = .left
    label.numberOfLines = 1
    label.text = "\(totalCost ?? 0) ETH"
    
    return label
  }()
  
  // MARK: - Private Methods:
  private func navBarSetup() {
    if (navigationController?.navigationBar) != nil {
      let rightButton = UIBarButtonItem(image: UIImage(named: "sortIcon"), style: .plain, target: self, action: #selector(sortButtonTapped))
      navigationItem.rightBarButtonItem = rightButton
    }
  }
  
  private func setupIU() {
    [nftTable, paymentView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    [payButton, nftCountLabel, totalCostLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      paymentView.addSubview($0)
    }
    
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
      totalCostLabel.trailingAnchor.constraint(equalTo: payButton.leadingAnchor, constant: -24),
      totalCostLabel.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 38),
      totalCostLabel.bottomAnchor.constraint(equalTo: paymentView.bottomAnchor, constant: -16)
    ])
  }
  
  private func updateNFTTableAnimatedly() {
    let unsortedArray = nfts
    switch sortType {
    case .byPrice:
      nfts.sort { $0.price > $1.price }
    case .byRating:
      nfts.sort { $0.rating > $1.rating }
    case .byName:
      nfts.sort { $0.name < $1.name }
    }
    
    var indexMapping = [Int: Int]()
    for (index, nft) in nfts.enumerated() {
      if let oldIndex = unsortedArray.firstIndex(where: { $0.id == nft.id }) {
        indexMapping[index] = oldIndex
      }
    }
    
    nftTable.performBatchUpdates({
      for (newIndex, oldIndex) in indexMapping {
        let oldIndexPath = IndexPath(row: oldIndex, section: 0)
        let newIndexPath = IndexPath(row: newIndex, section: 0)
        if oldIndexPath != newIndexPath {
          nftTable.moveRow(at: oldIndexPath, to: newIndexPath)
        }
      }
    }, completion: nil)
  }
  
  private func updateNFTTable() {
    switch sortType {
    case .byPrice:
      nfts.sort { $0.price > $1.price }
    case .byRating:
      nfts.sort { $0.rating > $1.rating }
    case .byName:
      nfts.sort { $0.name < $1.name }
    }
    nftTable.reloadData()
  }
}

// MARK: - LifeCycle:
extension CartViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    sortingAlertPresenter = SortingAlertPresenter(delegate: self)
    navBarSetup()
    setupIU()
    updateNFTTable()
  }
}

// MARK: - Objc-Methods:
extension CartViewController {
  @objc
  private func sortButtonTapped() {
    sortingAlertPresenter?.showAlert(
      model: SortingAlertModel(
        title: L10n.Localizable.Label.sortingTitle,
        message: nil,
        firstButtonText: SortType.byPrice.name,
        secondButtonText: SortType.byRating.name,
        thirdButtonText: SortType.byName.name,
        fourthButtonText: L10n.Localizable.Button.closeButtonTitle,
        firstCompletion: {
          self.sortType = .byPrice
          SortTypeStorage.sortType = .byPrice
        },
        secondCompletion: {
          self.sortType = .byRating
          SortTypeStorage.sortType = .byRating
        },
        thirdCompletion: {
          self.sortType = .byName
          SortTypeStorage.sortType = .byName
        }))
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
    nfts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let nft = nfts[indexPath.row]
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
    
  }
}
