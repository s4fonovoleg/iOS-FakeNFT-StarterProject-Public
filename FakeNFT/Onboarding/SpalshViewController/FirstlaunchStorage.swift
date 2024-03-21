import Foundation

final class FirstLaunchStorage {
  // MARK: - Properties:
  static let shared = FirstLaunchStorage()
  var wasLaunchedBefore: Bool {
    get {
      userDefaults.bool(forKey: "firstLaunch")
    }
    set {
      userDefaults.setValue(newValue, forKey: "firstLaunch")
    }
  }
  
  // MARK: - Private properties:
  private var userDefaults = UserDefaults.standard
}
