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
      /// Оплатить
      internal static let payTitle = L10n.tr("Localizable", "Button.PayTitle", fallback: "Оплатить")
      /// К оплате
      internal static let proceedToPayment = L10n.tr("Localizable", "Button.ProceedToPayment", fallback: "К оплате")
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
    internal enum Tab {
      /// Каталог
      internal static let catalog = L10n.tr("Localizable", "Tab.catalog", fallback: "Каталог")
    }
  }
  internal enum Main {
    internal enum _4N1BSJmX {
      /// Class = "UITabBarItem"; title = "Корзина"; ObjectID = "4N1-bS-JmX";
      internal static let title = L10n.tr("Main", "4N1-bS-JmX.title", fallback: "Корзина")
    }
    internal enum Bq6VkWno {
      /// Class = "UITabBarItem"; title = "Профиль"; ObjectID = "Bq6-vk-Wno";
      internal static let title = L10n.tr("Main", "Bq6-vk-Wno.title", fallback: "Профиль")
    }
    internal enum X74AkUx8 {
      /// Class = "UITabBarItem"; title = "Каталог"; ObjectID = "X74-Ak-ux8";
      internal static let title = L10n.tr("Main", "X74-Ak-ux8.title", fallback: "Каталог")
    }
    internal enum YldQuGf5 {
      /// Class = "UILabel"; text = "Статистика"; ObjectID = "YLD-QU-GF5";
      internal static let text = L10n.tr("Main", "YLD-QU-GF5.text", fallback: "Статистика")
    }
    internal enum CJeQjEp5 {
      /// Class = "UILabel"; text = "Профиль"; ObjectID = "cJe-qj-ep5";
      internal static let text = L10n.tr("Main", "cJe-qj-ep5.text", fallback: "Профиль")
    }
    internal enum Co5KxOQ8 {
      /// Class = "UIButton"; normalTitle = "Button"; ObjectID = "co5-kx-oQ8";
      internal static let normalTitle = L10n.tr("Main", "co5-kx-oQ8.normalTitle", fallback: "Button")
      internal enum Configuration {
        /// Class = "UIButton"; configuration.title = "Show nft id = 22"; ObjectID = "co5-kx-oQ8";
        internal static let title = L10n.tr("Main", "co5-kx-oQ8.configuration.title", fallback: "Show nft id = 22")
      }
    }
    internal enum He3Ik5Yf {
      /// Class = "UILabel"; text = "Корзина"; ObjectID = "hE3-IK-5YF";
      internal static let text = L10n.tr("Main", "hE3-IK-5YF.text", fallback: "Корзина")
    }
    internal enum QWkZTAG8 {
      /// Class = "UILabel"; text = "Каталог"; ObjectID = "qWk-zT-AG8";
      internal static let text = L10n.tr("Main", "qWk-zT-AG8.text", fallback: "Каталог")
    }
    internal enum XgD9YEGT {
      /// Class = "UITabBarItem"; title = "Корзина"; ObjectID = "xgD-9Y-EGT";
      internal static let title = L10n.tr("Main", "xgD-9Y-EGT.title", fallback: "Корзина")
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
