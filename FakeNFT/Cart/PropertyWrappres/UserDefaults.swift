import Foundation

@propertyWrapper struct UserDefaultEncoded {
  let userDefaults: UserDefaults
  let key: String
  let defaultValue: [String] = []
  
  init(userDefaults: UserDefaults = .standard, key: String) {
    self.userDefaults = userDefaults
    self.key = key
  }
  
  var wrappedValue: [String] {
    get {
      if let fetchedArray = userDefaults.array(forKey: key) as? [String] {
        return fetchedArray
      } else {
        return defaultValue
      }
    }
    set {
      userDefaults.set(newValue, forKey: key)
    }
  }
}

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
