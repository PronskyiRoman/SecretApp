import SwiftUI

public enum Asset {
  case checkMark
  case copy
  case cross
  case eyeOn
  case flashLight
  case logo
  case qrAngle
  case share
  case coins_v1
  case coins_v2
  case coins_v3
}

extension Asset {
  public var swiftUIImage: some View {
    switch self {
    case .checkMark: Image(.checkMark)
    case .copy: Image(.copy)
    case .cross: Image(.cross)
    case .eyeOn: Image(.eyeOn)
    case .flashLight: Image(.flashLight)
    case .logo: Image(.logo)
    case .qrAngle: Image(.qrAngle)
    case .share: Image(.share)
    case .coins_v1: Image(.coinsV1)
    case .coins_v2: Image(.coinsV2)
    case .coins_v3: Image(.coinsV3)
    }
  }
}
