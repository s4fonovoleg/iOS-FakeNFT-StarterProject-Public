// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum LaunchScreen {
    }
  internal enum Localizable {
    internal enum Button {
      /// Корзина
      internal static let cartTitle = L10n.tr("Localizable", "Button.cartTitle", fallback: "Корзина")
      /// Каталог
      internal static let catalogTitle = L10n.tr("Localizable", "Button.catalogTitle", fallback: "Каталог")
      /// Закрыть
      internal static let closeButtonTitle = L10n.tr("Localizable", "Button.closeButtonTitle", fallback: "Закрыть")
      /// Удалить
      internal static let deleteTitle = L10n.tr("Localizable", "Button.deleteTitle", fallback: "Удалить")
      /// Оплатить
      internal static let payTitle = L10n.tr("Localizable", "Button.payTitle", fallback: "Оплатить")
      /// К оплате
      internal static let proceedToPayment = L10n.tr("Localizable", "Button.proceedToPayment", fallback: "К оплате")
      /// Профиль
      internal static let profileTitle = L10n.tr("Localizable", "Button.profileTitle", fallback: "Профиль")
      /// Вернуться
      internal static let returnTitle = L10n.tr("Localizable", "Button.returnTitle", fallback: "Вернуться")
      /// По названию
      internal static let sortByNameTitle = L10n.tr("Localizable", "Button.sortByNameTitle", fallback: "По названию")
      /// По цене
      internal static let sortByPriceTitle = L10n.tr("Localizable", "Button.sortByPriceTitle", fallback: "По цене")
      /// По рейтингу
      internal static let sortByRatingTitle = L10n.tr("Localizable", "Button.sortByRatingTitle", fallback: "По рейтингу")
      /// Статистика
      internal static let statisticsTitle = L10n.tr("Localizable", "Button.statisticsTitle", fallback: "Статистика")
    }
    internal enum Catalog {
      /// Открыть Nft
      internal static let openNft = L10n.tr("Localizable", "Catalog.openNft", fallback: "Открыть Nft")
    }
    internal enum Error {
      /// Произошла ошибка сети
      internal static let network = L10n.tr("Localizable", "Error.network", fallback: "Произошла ошибка сети")
      /// Повторить
      internal static let `repeat` = L10n.tr("Localizable", "Error.repeat", fallback: "Повторить")
      /// Ошибка
      internal static let title = L10n.tr("Localizable", "Error.title", fallback: "Ошибка")
      /// Произошла неизвестная ошибка
      internal static let unknown = L10n.tr("Localizable", "Error.unknown", fallback: "Произошла неизвестная ошибка")
    }
    internal enum Label {
      /// Вы уверены, что хоитите 
      /// удалить объект из корзины?
      internal static let deleteNftLabel = L10n.tr("Localizable", "Label.deleteNftLabel", fallback: "Вы уверены, что хоитите \nудалить объект из корзины?")
      /// Корзина пуста
      internal static let emptyCartTitle = L10n.tr("Localizable", "Label.emptyCartTitle", fallback: "Корзина пуста")
      /// Цена
      internal static let priceTitle = L10n.tr("Localizable", "Label.priceTitle", fallback: "Цена")
      /// Сортировка
      internal static let sortingTitle = L10n.tr("Localizable", "Label.sortingTitle", fallback: "Сортировка")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type