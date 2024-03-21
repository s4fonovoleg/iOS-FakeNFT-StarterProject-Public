import Foundation

struct ModelOfError {
  let message: String
  let actionText: String
  let cancelText: String
  let action: (() -> Void)
}
