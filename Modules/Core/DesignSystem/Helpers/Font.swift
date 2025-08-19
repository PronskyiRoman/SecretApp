import SwiftUI

// MARK: - Font names
private enum Constants {
  static let bootonTRIA: String = "Booton TRIAL"
  static let sfPro: String = "SF Pro"
}

public extension Font {
  // MARK: - Title H5
  static var titleH5Title: Self { makeDefaultFont(size: 24) }

  // MARK: - Label
  static var labelXSmall: Self { makeDefaultFont(size: 12) }
  static var labelTiny: Self { makeFont(Constants.sfPro, size: 12, weight: .regular) }
  static var labelSmall: Self { makeDefaultFont(size: 14) }
  static var labelMedium: Self { makeDefaultFont(size: 16) }
  static var labelLarge: Self { makeDefaultFont(size: 18) }

  // MARK: - Paragraph
  static var paragraphSmall: Self { makeDefaultFont(size: 14) }
  static var paragraphMedium: Self { makeDefaultFont(size: 16) }
  static var paragraphLarge: Self { makeDefaultFont(size: 24, weight: .regular) }
}

// MARK: - Helpers
private extension Font {
  static func makeDefaultFont(size: CGFloat, weight: Font.Weight = .medium) -> Font {
    makeFont(Constants.bootonTRIA, size: size, weight: weight)
  }

  static func makeFont(
    _ name: String,
    size: CGFloat,
    weight: Font.Weight
  ) -> Font {
    .custom(name, size: size).weight(weight)
  }
}
