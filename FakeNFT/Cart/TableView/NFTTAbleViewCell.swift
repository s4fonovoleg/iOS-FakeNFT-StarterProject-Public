import Foundation
import UIKit

protocol NFTTableViewCellDelegate: AnyObject {
  func deleteButtopnPressed()
}

final class NFTTAbleViewCell: UITableViewCell {
  // MARK: - Properties:
  static let reuseID = "nftTableViewCell"
  weak var delegate: NFTTableViewCellDelegate?
  
  // MARK: - Private Properties:
  private lazy var nftImageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    
    return image
  }()
  
  private lazy var nftInfoView: UIView = {
    let infoView = UIView()
    infoView.backgroundColor = .clear
    
    return infoView
  }()
  
  private lazy var nftNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .YPBlack
    label.font = .bodyBold
    
    return label
  }()
  
  private lazy var priceLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .YPBlack
    label.text = L10n.Localizable.Lable.priceTitle
    label.font = .caption2
    
    return label
  }()
  
  private lazy var nftPriceLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .YPBlack
    label.font = .bodyBold
    
    return label
  }()
  
  private lazy var deleteButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "DeleteCartIcon"), for: .normal)
    button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    button.tintColor = .YPBlack
    
    return button
  }()
  
  // MARK: - LifeCycle:
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods:
  func configureCell(for nft: NFTModel) {
    let image = nft.image
    nftImageView.image = image
    nftNameLabel.text = nft.name
    nftPriceLabel.text = "\(nft.price) ETH"
  }
  
  // MARK: - Private Methods:
  func setupUI() {
    [nftImageView, nftInfoView, deleteButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    [nftNameLabel, nftPriceLabel, priceLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      nftInfoView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      nftImageView.heightAnchor.constraint(equalToConstant: 108),
      nftImageView.widthAnchor.constraint(equalToConstant: 108),
      nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      
      nftInfoView.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
      nftInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -156),
      nftInfoView.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 8),
      nftInfoView.bottomAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: -8),
      
      deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
      deleteButton.widthAnchor.constraint(equalToConstant: 40),
      deleteButton.heightAnchor.constraint(equalToConstant: 40),
      
      nftNameLabel.leadingAnchor.constraint(equalTo: nftInfoView.leadingAnchor),
      nftNameLabel.trailingAnchor.constraint(equalTo: nftInfoView.trailingAnchor),
      nftNameLabel.topAnchor.constraint(equalTo: nftInfoView.topAnchor),
      nftNameLabel.bottomAnchor.constraint(equalTo: nftInfoView.bottomAnchor, constant: -70),
      
      priceLabel.leadingAnchor.constraint(equalTo: nftInfoView.leadingAnchor),
      priceLabel.trailingAnchor.constraint(equalTo: nftInfoView.trailingAnchor),
      priceLabel.topAnchor.constraint(equalTo: nftNameLabel.bottomAnchor, constant: 28),
      priceLabel.bottomAnchor.constraint(equalTo: nftInfoView.bottomAnchor, constant: -24),
      
      nftPriceLabel.leadingAnchor.constraint(equalTo: nftInfoView.leadingAnchor),
      nftPriceLabel.trailingAnchor.constraint(equalTo: nftInfoView.trailingAnchor),
      nftPriceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 2),
      nftPriceLabel.bottomAnchor.constraint(equalTo: nftInfoView.bottomAnchor)
    ])
  }
}

// MARK: - objc-Methods:
extension NFTTAbleViewCell {
  @objc
  private func deleteButtonTapped() {
    delegate?.deleteButtopnPressed()
  }
}
