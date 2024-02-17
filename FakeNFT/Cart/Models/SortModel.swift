import Foundation

enum SortType: String {
  case byPrice
  case byRating
  case byName
  
  var name: String {
    switch self {
    case .byPrice:
      return L10n.Localizable.Button.sortByPriceTitle
    case .byRating:
      return L10n.Localizable.Button.sortByRatingTitle
    case.byName:
      return L10n.Localizable.Button.sortByNameTitle
    }
  }
}
