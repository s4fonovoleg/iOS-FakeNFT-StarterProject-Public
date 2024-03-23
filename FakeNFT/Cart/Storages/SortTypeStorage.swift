import Foundation

struct SortTypeStorage {
  // MARK: - Properties:
  @UserDefaultsSortType(key: "SortType") static var sortType: SortType
}
