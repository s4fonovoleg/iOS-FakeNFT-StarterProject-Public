import Foundation

extension Float {
  private static let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    formatter.decimalSeparator = ","
    
    return formatter
  }()
  
  func stringWithCommaSeparator() -> String {
    return Float.formatter.string(from: NSNumber(value: self)) ?? "\(self)"
  }
}
