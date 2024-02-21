import Foundation

protocol UserAgreementViewModelProtocol: AnyObject {
  var onChangeProgress: ((Float) -> Void)? { get set }
  var onChangeVisibility: ((Bool) -> Void)? { get set }
  func updateProgressView(_ value: Double)
}

final class UserAgreementViewModel: UserAgreementViewModelProtocol {
  // MARK: - Properties:
  var onChangeProgress: ((Float) -> Void)?
  var onChangeVisibility: ((Bool) -> Void)?
  
  // MARK: - Methods:
  func updateProgressView(_ value: Double) {
    onChangeProgress?(Float(value))
    
    if value == 1 {
      onChangeVisibility?(true)
    }
  }
}
