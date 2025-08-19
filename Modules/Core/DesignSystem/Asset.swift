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
  public var swiftUIImage: Image {
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

  public var uiImage: UIImage {
    switch self {
    case .checkMark: UIImage(resource: .checkMark)
    case .copy: UIImage(resource: .copy)
    case .cross: UIImage(resource: .cross)
    case .eyeOn: UIImage(resource: .eyeOn)
    case .flashLight: UIImage(resource: .flashLight)
    case .logo: UIImage(resource: .logo)
    case .qrAngle: UIImage(resource: .qrAngle)
    case .share: UIImage(resource: .share)
    case .coins_v1: UIImage(resource: .coinsV1)
    case .coins_v2: UIImage(resource: .coinsV2)
    case .coins_v3: UIImage(resource: .coinsV3)
    }
  }
}
