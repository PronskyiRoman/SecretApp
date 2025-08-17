import Profile
import ArchitectureTools
import SwiftUI
import ScannerUI
import MyCodeUI

@ViewAction(for: Profile.self)
public struct ProfileView: View {
  @ArchitectureTools.Bindable public var store: StoreOf<Profile>

  public init(store: StoreOf<Profile>) {
    self.store = store
  }

  public var body: some View {
    content
  }
}

private extension ProfileView {
  var content: some View {
    tabView
      .overlay {
        selectionView
      }
  }

  var tabView: some View {
    TabView(
      selection: $store.selectedSegment.sending(\.view.didSelect),
      content: {
        ForEach(Profile.Segment.segments, id: \.self) {
          $0.view(store: store)
            .transition(.slide)
        }
      })
    .tabViewStyle(.page(indexDisplayMode: .never))
    .indexViewStyle(.page(backgroundDisplayMode: .never))
  }

  var selectionView: some View {
    HStack {
      Button("codeScanner") {
        send(.didSelect(.codeScanner), animation: .default)
      }

      Button("myCode") {
        send(.didSelect(.myCode), animation: .default)
      }
    }
  }
}

private extension Profile.Segment {
  static let segments: [Self] = [
    .codeScanner,
    .myCode
  ]

  @ViewBuilder
  func view(store: StoreOf<Profile>) -> some View {
    switch self {
    case .codeScanner:
      ScannerView(store: store.scope(state: \.scanner, action: \.scanner))
    case .myCode:
      MyCodeView(store: store.scope(state: \.myCode, action: \.myCode))
    }
  }
}
