import Foundation
import UIKit

final class OnboardingViewController: UIPageViewController {
  // MARK: - Private Properties:
  private lazy var pages: [UIViewController] = {
    let firstPageViewController = FirstPageViewController()
    let secondPageViewController = SecondPageViewController()
    let thirdPageViewController = ThirdPageViewController()
    
    return [firstPageViewController, secondPageViewController, thirdPageViewController]
  }()
}
