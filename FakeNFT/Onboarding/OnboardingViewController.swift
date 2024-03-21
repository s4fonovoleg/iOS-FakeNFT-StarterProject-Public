import Foundation
import UIKit

final class OnboardingViewController: UIPageViewController {
  // MARK: - Private Properties:
  private let viewModel = OnboardingViewModel()
  private lazy var closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .clear
    button.setImage(Asset.CustomIcons.closeButton.image, for: .normal)
    button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    button.tintColor = Asset.CustomColors.ypWhiteUniversal.color
    
    return button
  }()
  
  private lazy var indicatorsStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.spacing = 8
    stack.distribution = .equalSpacing
    
    return stack
  }()
  
  // MARK: - Private Methods:
  override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayout() {
    [closeButton, indicatorsStack].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
      closeButton.widthAnchor.constraint(equalToConstant: 42),
      closeButton.heightAnchor.constraint(equalToConstant: 42),
      
      indicatorsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
      indicatorsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      indicatorsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      indicatorsStack.heightAnchor.constraint(equalToConstant: 4)
    ])
  }
  
  private func configureindicatorsStack() {
    for _ in 0..<viewModel.pages.count {
      let indicatorView = UIView()
      indicatorView.layer.cornerRadius = 2
      indicatorView.backgroundColor = Asset.CustomColors.ypWhiteUniversal.color
      indicatorView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        indicatorView.heightAnchor.constraint(equalToConstant: 4),
        indicatorView.widthAnchor.constraint(equalToConstant: 109)
      ])
      indicatorsStack.addArrangedSubview(indicatorView)
    }
  }
  
  private func setIndicator(on page: Int) {
    for (index, indicatorView) in indicatorsStack.arrangedSubviews.enumerated() {
      indicatorView.backgroundColor = index == page ? Asset.CustomColors.ypWhiteUniversal.color : Asset.CustomColors.ypGray.color
    }
  }
}

// MARK: - LifeCycle:
extension OnboardingViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    delegate = self
    setupLayout()
    setupConstraints()
    if let firstPage = viewModel.pages.first {
      setViewControllers([firstPage], direction: .forward, animated: true)
    }
    configureindicatorsStack()
    setIndicator(on: 0)
    viewModel.onChange = { [weak self] current, last in
      self?.setIndicator(on: current)
      self?.closeButton.isHidden = current == last
    }
  }
}

// MARK: - Objc-Methods:
extension OnboardingViewController {
  @objc private func closeButtonTapped() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      fatalError("Не удалось инициализировать AppDelegate")
    }
    appDelegate.window?.rootViewController = TabBarController()
  }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = viewModel.pages.firstIndex(of: viewController) else {
      return nil
    }
    
    let previousIndex = viewControllerIndex - 1
    
    guard previousIndex >= 0 else {
      return viewModel.pages.last
    }
    
    return viewModel.pages[previousIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = viewModel.pages.firstIndex(of: viewController) else {
      return nil
    }
    
    let nextIndex = viewControllerIndex + 1
    guard nextIndex < viewModel.pages.count else {
      return viewModel.pages.first
    }
    return viewModel.pages[nextIndex]
  }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    let lastPageIndex = viewModel.pages.count - 1
    if let currentViewController = pageViewController.viewControllers?.first,
       let currentIndex = viewModel.pages.firstIndex(of: currentViewController) {
      viewModel.updateUI(for: currentIndex, and: lastPageIndex)
    }
  }
}
