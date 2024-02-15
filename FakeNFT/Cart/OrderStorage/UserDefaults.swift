import Foundation

@propertyWrapper struct UserDefaultEncoded<T: Codable> {
  let key: String
  let defaultValue: T?
  let decoder = JSONDecoder()
  let encoder = JSONEncoder()
  
  init(key: String, default: T? = nil) {
    self.key = key
    defaultValue = `default`
  }
  
  var wrappedValue: T? {
    get {
      guard let jsonString = UserDefaults.standard.string(forKey: key) else {
        return defaultValue
      }
      guard let jsonData = jsonString.data(using: .utf8) else {
        return defaultValue
      }
      guard let value = try? decoder.decode(T.self, from: jsonData) else {
        return defaultValue
      }
      return value
    }
    set {
      encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
      guard let jsonData = try? encoder.encode(newValue) else { return }
      let jsonString = String(bytes: jsonData, encoding: .utf8)
      UserDefaults.standard.set(jsonString, forKey: key)
    }
  }
}
