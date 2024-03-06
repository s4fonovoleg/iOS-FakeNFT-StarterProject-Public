import Foundation

struct ReviewRequestStorage {
  // MARK: - Properties:
  @UserDefaultsReviewCounter(key: "ReviewRequest") static var reviewRequestCounter: Int 
}
