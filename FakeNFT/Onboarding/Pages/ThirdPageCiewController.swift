import Foundation
import UIKit

final class ThirdPageViewController: UIViewController {
  // MARK: - Private Properties:
  private lazy var imageView: UIImageView = {
    let image = Asset.CustomImages.thirdPageImage.image
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFill
    
    return imageView
  }()
  
  private lazy var headerTitle: UILabel = {
    let label = UILabel()
    label.text = L10n.Localizable.Label.thirdPageCompeteTitle
    label.font = .headline5
    label.textAlignment = .left
    label.textColor = Asset.CustomColors.ypWhiteUniversal.color
    
    return label
  }()
  
  private lazy var textLabel: UILabel = {
    let label = UILabel()
    label.text = L10n.Localizable.Label.thirdPageTitle
    label.numberOfLines = 2
    label.font = .caption1
    label.textAlignment = .left
    label.textColor = Asset.CustomColors.ypWhiteUniversal.color
    
    return label
  }()
  
  private lazy var whatsInsideButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(L10n.Localizable.Button.whatsInsideTitle, for: .normal)
    button.titleLabel?.font = .bodyBold
    button.backgroundColor = Asset.CustomColors.ypBlackUniversal.color
    button.setTitleColor(Asset.CustomColors.ypWhiteUniversal.color, for: .normal)
    button.layer.cornerRadius = 16
    button.layer.masksToBounds = true
    button.addTarget(self, action: #selector(switchToTabBar), for: .touchUpInside)
    
    return button
  }()
  
  // MARK: - Private Methods:
  private func setupLayout() {
    [imageView, headerTitle, textLabel, whatsInsideButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageView.topAnchor.constraint(equalTo: view.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      headerTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      headerTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
      headerTitle.heightAnchor.constraint(equalToConstant: 41),
      
      textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      textLabel.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 12),
      textLabel.heightAnchor.constraint(equalToConstant: 40),
      
      whatsInsideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      whatsInsideButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      whatsInsideButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -66),
      whatsInsideButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  private func makeGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.frame
    gradientLayer.colors = [Asset.CustomColors.ypBlackUniversal.color.cgColor, UIColor.clear.cgColor]
    gradientLayer.locations = [0.0, 0.7]
    imageView.layer.addSublayer(gradientLayer)
  }
}

// MARK: - LifeCycle:
extension ThirdPageViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
    setupConstraints()
    makeGradient()
  }
}

// MARK: - Objc-Methods:
extension ThirdPageViewController {
  @objc private func switchToTabBar() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      fatalError("Не удалось инициализировать AppDelegate")
    }
    appDelegate.window?.rootViewController = TabBarController()
  }
}
