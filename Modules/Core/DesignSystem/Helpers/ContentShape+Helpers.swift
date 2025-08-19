import SwiftUI

public extension ShapeStyle where Self == Color {
  // MARK: - Neutral
  static var alphaNeutralAlpha16: Self { Color(hex: "#8D8D8D").opacity(0.16) }
  static var alphaNeutralAlpha54: Self { Color(hex: "#000205").opacity(0.54) }

  // MARK: - BG
  static var bgPrimary: Self { Color(hex: "#000205") }
  static var bgSecondary: Self { Color(hex: "#1A1A1A") }
  static var bgTertiary: Self { Color(hex: "#000000").opacity(0.5) }

  // MARK: - Text
  static var textPrimary: Self { Color(hex: "#FFFFFF") }
  static var textSecondary: Self { Color(hex: "#8D8D8D") }

  // MARK: - Button
  static var buttonPrimaryContentActive: Self { Color(hex: "#FFFFFF") }
  static var buttonPrimaryBgActive: Self { Color(hex: "#2979FF") }
  static var buttonTertiaryBgActive: Self { Color(hex: "##FFFFFF").opacity(0) }

  // MARK: - Gradient
  static var gradientStart: Self { Color(hex: "#2979FF") }
  static var gradientEnd: Self { Color(hex: "#29FFF4") }
}
