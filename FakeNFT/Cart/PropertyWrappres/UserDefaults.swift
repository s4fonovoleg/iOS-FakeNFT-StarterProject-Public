import Foundation

@propertyWrapper struct UserDefaultsSortType {
  let userDefaults: UserDefaults
  let key: String
  
  init(userDefaults: UserDefaults = .standard, key: String) {
    self.userDefaults = userDefaults
    self.key = key
  }
  
  var wrappedValue: SortType {
    get {
      SortType(rawValue: userDefaults.string(forKey: key) ?? "SortType") ?? .byName
    }
    set {
      userDefaults.set(newValue.rawValue, forKey: key)
    }
  }
}
