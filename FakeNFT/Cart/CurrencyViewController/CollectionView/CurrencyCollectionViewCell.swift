import Foundation
import UIKit
import Kingfisher

final class CurrencyCollectionViewCell: UICollectionViewCell {
  // MARK: - Properties:
  static let reuseID = "CurrencyCollectionViewCell"
  
  // MARK: - Private Properties:
  private lazy var currencyImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 6
    imageView.layer.masksToBounds = true
    imageView.backgroundColor = .YPBlackUniversal
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  private lazy var currencyNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .YPBlack
    label.font = .caption2
    
    return label
  }()
  
  private lazy var currencyShortNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .YPGreen
    label.font = .caption2
    
    return label
  }()
  
  // MARK: - Methods:
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCell(_ model: CurrencyModel) {
    guard let url = URL(string: model.image) else { return }
    currencyImageView.kf.setImage(
      with: url,
      placeholder: UIImage(named: "placeholder"),
      options: [.transition(.fade(1))])
    currencyNameLabel.text = model.title
    currencyShortNameLabel.text = model.name
  }
  
  // MARK: - Private Methods
  private func setupLayout() {
    [currencyImageView, currencyNameLabel, currencyShortNameLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      currencyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      currencyImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      currencyImageView.heightAnchor.constraint(equalToConstant: 36),
      currencyImageView.widthAnchor.constraint(equalToConstant: 36),
      
      currencyNameLabel.leadingAnchor.constraint(equalTo: currencyImageView.trailingAnchor, constant: 4),
      currencyNameLabel.topAnchor.constraint(equalTo: currencyImageView.topAnchor),
      currencyNameLabel.widthAnchor.constraint(equalToConstant: 60),
      currencyNameLabel.heightAnchor.constraint(equalToConstant: 18),
      
      currencyShortNameLabel.leadingAnchor.constraint(equalTo: currencyNameLabel.leadingAnchor),
      currencyShortNameLabel.topAnchor.constraint(equalTo: currencyNameLabel.bottomAnchor),
      currencyShortNameLabel.widthAnchor.constraint(equalToConstant: 40),
      currencyShortNameLabel.heightAnchor.constraint(equalToConstant: 18)
    ])
  }
}
