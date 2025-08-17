import SwiftUI

extension Color {
  public init(hex value: String) {
      var formattedString = value.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
      if formattedString.hasPrefix("#") {
          formattedString.remove(at: formattedString.startIndex)
      }

      var rgbValue: UInt64 = 0
      Scanner(string: formattedString).scanHexInt64(&rgbValue)

      let hasAlpha = formattedString.count == 8
      let divisor: CGFloat = 255.0

      let red = CGFloat((rgbValue & 0xFF0000) >> 16) / divisor
      let green = CGFloat((rgbValue & 0x00FF00) >> 8) / divisor
      let blue = CGFloat(rgbValue & 0x0000FF) / divisor
      let alpha = hasAlpha ? CGFloat((rgbValue & 0xFF000000) >> 24) / divisor : 1.0
      let uiColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)

      self.init(uiColor: uiColor)
  }
}
