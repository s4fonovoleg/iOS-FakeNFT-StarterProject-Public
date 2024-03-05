import Foundation
import UIKit

final class SpalshViewController: UIViewController {
  // MARK: - Private Properties:
  private let firstLaunchStorage = FirstLaunchStorage.shared
  
  private lazy var logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFill
    imageView.image = Asset.CustomIcons.praktikumLogo.image
    
    return imageView
  }()
  
  // MARK: - Private Methods:
  private func setupLayout() {
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(logoImageView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      logoImageView.widthAnchor.constraint(equalToConstant: 75),
      logoImageView.heightAnchor.constraint(equalToConstant: 77.68)
    ])
  }
  
  private func checkIfFirstLaunch() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      fatalError("Не удалось инициализировать AppDelegate")
    }
    if firstLaunchStorage.wasLaunchedBefore {
      appDelegate.window?.rootViewController = TabBarController()
    } else {
      appDelegate.window?.rootViewController = OnboardingViewController()
      firstLaunchStorage.wasLaunchedBefore = true
    }
  }
}

// MARK: - LifeCycle:
extension SpalshViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setupLayout()
    setupConstraints()
  }
}
