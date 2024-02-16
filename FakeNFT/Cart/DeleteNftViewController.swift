import Foundation
import UIKit
import Kingfisher

protocol DeleteNFTViewControllerDelegate: AnyObject {
  func removeNFT(model: NFTModel)
}

final class DeleteNftViewController: UIViewController {
  // MARK: - Properties
  weak var delegate: DeleteNFTViewControllerDelegate?
  
  // MARK: - Private Properties:
  private var modelTodelete: NFTModel?
  private lazy var deleteView: UIView = {
    let deleteView = UIView()
    deleteView.backgroundColor = .clear
    
    return deleteView
  }()
  
  private lazy var nftImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 12
    imageView.layer.masksToBounds = true

    return imageView
  }()
  
  private lazy var deleteLabel: UILabel = {
    let label = UILabel()
    label.font = .caption2
    label.text = L10n.Localizable.Label.deleteNftLabel
    label.textColor = .YPBlack
    label.numberOfLines = 2
    label.textAlignment = .center
    
    return label
  }()
  
  private lazy var deleteButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitleColor(.YPRed, for: .normal)
    button.setTitle(L10n.Localizable.Button.deleteTitle, for: .normal)
    button.backgroundColor = .YPBlack
    button.layer.cornerRadius = 12
    button.layer.masksToBounds = true
    button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var returnButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitleColor(.YPWhite, for: .normal)
    button.setTitle(L10n.Localizable.Button.returnTitle, for: .normal)
    button.backgroundColor = .YPBlack
    button.layer.cornerRadius = 12
    button.layer.masksToBounds = true
    button.addTarget(self, action: #selector(returnButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  // MARK: - Private methods:
  init(delegate: DeleteNFTViewControllerDelegate, modelTodelete: NFTModel) {
    self.delegate = delegate
    self.modelTodelete = modelTodelete
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupBlurBackground() {
    let blurffect = UIBlurEffect(style: .light)
    let blurView = UIVisualEffectView(effect: blurffect)
    blurView.frame = view.bounds
    blurView.alpha = 0.985
    view.addSubview(blurView)
    view.sendSubviewToBack(blurView)
    view.backgroundColor = .clear
  }
  
  private func setupUI() {
    deleteView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(deleteView)
    [nftImageView, deleteLabel, deleteButton, returnButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      deleteView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      deleteView.topAnchor.constraint(equalTo: view.topAnchor, constant: 224),
      deleteView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      deleteView.widthAnchor.constraint(equalToConstant: 262),
      deleteView.heightAnchor.constraint(equalToConstant: 220),
      
      nftImageView.topAnchor.constraint(equalTo: deleteView.topAnchor),
      nftImageView.centerXAnchor.constraint(equalTo: deleteView.centerXAnchor),
      nftImageView.widthAnchor.constraint(equalToConstant: 108),
      nftImageView.heightAnchor.constraint(equalToConstant: 108),
      
      deleteLabel.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 12),
      deleteLabel.centerXAnchor.constraint(equalTo: nftImageView.centerXAnchor),
      deleteLabel.leadingAnchor.constraint(equalTo: deleteView.leadingAnchor, constant: 41),
      deleteLabel.trailingAnchor.constraint(equalTo: deleteView.trailingAnchor, constant: -41),
      
      deleteButton.topAnchor.constraint(equalTo: deleteLabel.bottomAnchor, constant: 20),
      deleteButton.leadingAnchor.constraint(equalTo: deleteView.leadingAnchor),
      deleteButton.widthAnchor.constraint(equalToConstant: 127),
      deleteButton.heightAnchor.constraint(equalToConstant: 44),
      
      returnButton.topAnchor.constraint(equalTo: deleteButton.topAnchor),
      returnButton.trailingAnchor.constraint(equalTo: deleteView.trailingAnchor),
      returnButton.heightAnchor.constraint(equalToConstant: 44),
      returnButton.widthAnchor.constraint(equalToConstant: 127)
    ])
    setDeleteImage()
  }
  
  private func setDeleteImage() {
    if let url = modelTodelete?.images.first {
      nftImageView.kf.setImage(with: url)
    }
  }
}

// MARK: - LifeCycle:
extension DeleteNftViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBlurBackground()
    setupUI()
  }
  
  override var prefersStatusBarHidden: Bool {
    true
  }
}

// MARK: - objc-Methods:
extension DeleteNftViewController {
  @objc private func returnButtonTapped() {
    self.dismiss(animated: true)
  }
  
  @objc private func deleteButtonTapped() {
    
  }
}
