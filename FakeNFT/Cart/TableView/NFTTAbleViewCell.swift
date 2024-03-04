import Foundation
import UIKit
import Kingfisher

protocol NFTTableViewCellDelegate: AnyObject {
  func deleteButtopnPressed(on model: NFTModel)
}

final class NFTTAbleViewCell: UITableViewCell {
  // MARK: - Properties:
  static let reuseID = "nftTableViewCell"
  weak var delegate: NFTTableViewCellDelegate?
  
  // MARK: - Private Properties:
  private var nftModel: NFTModel?
  private lazy var nftImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 12
    imageView.layer.masksToBounds = true
    
    return imageView
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
    label.textColor = Asset.CustomColors.ypBlack.color
    label.font = .bodyBold
    
    return label
  }()
  
  private lazy var ratingStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.spacing = 2
    
    return stack
  }()
  
  private lazy var priceLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = Asset.CustomColors.ypBlack.color
    label.text = L10n.Localizable.Label.priceTitle
    label.font = .caption2
    
    return label
  }()
  
  private lazy var nftPriceLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = Asset.CustomColors.ypBlack.color
    label.font = .bodyBold
    
    return label
  }()
  
  private lazy var deleteButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(Asset.CustomIcons.deleteCartIcon.image, for: .normal)
    button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    button.tintColor = Asset.CustomColors.ypBlack.color
    
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
    let formattedPrice = nft.price.stringWithCommaSeparator()
    nftNameLabel.text = nft.name
    nftPriceLabel.text = "\(formattedPrice) ETH"
    setNFTRating(on: nft.rating)
    let url = nft.images.first
    nftImageView.kf.indicatorType = .activity
    nftImageView.kf.setImage(
      with: url,
      placeholder: Asset.CustomImages.placeholder.image,
      options: [.transition(.fade(1))])
    nftModel = nft
  }
  
  // MARK: - Private Methods:
  func setupUI() {
    [nftImageView, nftInfoView, deleteButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    [nftNameLabel, ratingStackView, nftPriceLabel, priceLabel].forEach {
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
      nftNameLabel.widthAnchor.constraint(equalToConstant: 150),
      nftNameLabel.topAnchor.constraint(equalTo: nftInfoView.topAnchor),
      nftNameLabel.bottomAnchor.constraint(equalTo: nftInfoView.bottomAnchor, constant: -70),
      
      ratingStackView.leadingAnchor.constraint(equalTo: nftInfoView.leadingAnchor),
      ratingStackView.topAnchor.constraint(equalTo: nftNameLabel.bottomAnchor, constant: 4),
      ratingStackView.heightAnchor.constraint(equalToConstant: 12),
      
      priceLabel.leadingAnchor.constraint(equalTo: nftInfoView.leadingAnchor),
      priceLabel.trailingAnchor.constraint(equalTo: nftInfoView.trailingAnchor),
      priceLabel.topAnchor.constraint(equalTo: nftNameLabel.bottomAnchor, constant: 28),
      priceLabel.bottomAnchor.constraint(equalTo: nftInfoView.bottomAnchor, constant: -24),
      
      nftPriceLabel.leadingAnchor.constraint(equalTo: nftInfoView.leadingAnchor),
      nftPriceLabel.trailingAnchor.constraint(equalTo: nftInfoView.trailingAnchor),
      nftPriceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 2),
      nftPriceLabel.bottomAnchor.constraint(equalTo: nftInfoView.bottomAnchor)
    ])
    configureRatingStackView()
  }
  
  private func configureRatingStackView() {
    let image = UIImage(systemName: "star.fill")
    for _ in 0..<5 {
      let starImageView = UIImageView(image: image)
      starImageView.tintColor = Asset.CustomColors.ypLightGrey.color
      NSLayoutConstraint.activate([
        starImageView.heightAnchor.constraint(equalToConstant: 12),
        starImageView.widthAnchor.constraint(equalToConstant: 12)
      ])
      ratingStackView.addArrangedSubview(starImageView)
    }
  }
  
  private func setNFTRating(on rating: Int) {
    let value = rating
    let defaultValue = value <= 5 ? value: 5
    for value in 0..<defaultValue {
      ratingStackView.arrangedSubviews[value].tintColor = Asset.CustomColors.ypYellow.color
    }
    
    for value in defaultValue..<5 {
      ratingStackView.arrangedSubviews[value].tintColor = Asset.CustomColors.ypLightGrey.color
    }
  }
}

// MARK: - objc-Methods:
extension NFTTAbleViewCell {
  @objc
  private func deleteButtonTapped() {
    guard let nftModel else { return }
    delegate?.deleteButtopnPressed(on: nftModel)
  }
}
