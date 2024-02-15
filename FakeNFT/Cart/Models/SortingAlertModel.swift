import Foundation

struct SortingAlertModel {
  let title: String
  let message: String?
  let firstButtonText: String
  let secondButtonText: String
  let thirdButtonText: String
  let fourthButtonText: String
  let firstCompletion: (() -> Void)
  let secondCompletion: (() -> Void)
  let thirdCompletion: (() -> Void)
}
