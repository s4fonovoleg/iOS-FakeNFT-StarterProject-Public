import Foundation
import UIKit

final class OnboardingViewModel {
  // MARK: - Properties:
  var onChange: ((Int, Int) -> Void)?
  var pages: [UIViewController] = {
    let firstPageViewController = FirstPageViewController()
    let secondPageViewController = SecondPageViewController()
    let thirdPageViewController = ThirdPageViewController()
    
    return [firstPageViewController, secondPageViewController, thirdPageViewController]
  }()
  
  // MARK: - Methods:
  func updateUI(for currentPageIndex: Int, and lastPageIndex: Int ) {
    onChange?(currentPageIndex, lastPageIndex)
  }
}
