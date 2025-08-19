import Profile
import ArchitectureTools
import SwiftUI
import ScannerUI
import MyCodeUI
import DesignSystem

@ViewAction(for: Profile.self)
public struct ProfileView: View {
  public var store: StoreOf<Profile>

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
      .ignoresSafeArea()
      .overlay(alignment: .bottom) {
        selectionView
      }
      .background(background)
  }

  var background: some View {
    Color.bgPrimary.ignoresSafeArea()
  }

  var tabView: some View {
    WithPerceptionTracking(content: {
      @ArchitectureTools.Bindable var store = store
      TabView(
        selection: $store.selectedSegment.sending(\.view.didSelect),
        content: {
          ForEach(Profile.Segment.segments, id: \.self) {
            $0.view(store: store)
              .transition(.slide)
              .tag($0)
          }
        })
      .tabViewStyle(.page(indexDisplayMode: .never))
      .indexViewStyle(.page(backgroundDisplayMode: .never))
    })
  }
  
  var selectionView: some View {
    HStack(alignment: .center, spacing: .zero) {
      ForEach(Profile.Segment.segments, id: \.self) { segment in
        button(
          title: buttonTitle(segment),
          action: { buttonAction(segment) })
      }
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .background(selectionBackground)
    .padding(.all, 4)
    .background(.alphaNeutralAlpha54)
    .cornerRadius(Constants.cornerRadius)
    .padding(.init(top: 6, leading: 56, bottom: 16, trailing: 56))
  }
  
  var isSelected: (Profile.Segment) -> Bool {{
    store.viewModel.isSelected($0)
  }}
  
  var buttonTitle: (_ segment: Profile.Segment) -> String {{
    switch $0 {
    case .codeScanner: store.viewModel.codeScannerTitle
    case .myCode: store.viewModel.myCodeTitle
    }
  }}

  var buttonAction: (Profile.Segment) -> Void {{
    send(.didSelect($0), animation: .default)
  }}
  
  var selectionBackground: some View {
    GeometryReader { geo in
      WithPerceptionTracking(content: {
        let data = Profile.Segment.segments
        let selectedIndex = data.firstIndex(where: isSelected) ?? 0
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
          .fill(.alphaNeutralAlpha16)
          .animation(.spring().speed(1.5), value: selectedIndex)
          .frame(width: geo.size.width / CGFloat(data.count))
          .offset(x: geo.size.width / CGFloat(data.count) * CGFloat(selectedIndex), y: 0)
      })
    }
  }

  func button(title: String, action: @escaping () -> Void) -> some View {
    Button(action: action) {
      Text(title)
        .foregroundStyle(.textPrimary)
        .font(.labelMedium)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.init(top: 16, leading: 8, bottom: 16, trailing: 8))
    }
  }
}

private enum Constants {
  static let cornerRadius: CGFloat = 40
}

private extension Profile.Segment {
  static let segments: [Self] = [
    .codeScanner,
    .myCode
  ]

  @ViewBuilder
  func view(store: StoreOf<Profile>) -> some View {
    WithPerceptionTracking(content: {
      switch self {
      case .codeScanner:
        ScannerView(store: store.scope(state: \.scanner, action: \.scanner))
      case .myCode:
        MyCodeView(store: store.scope(state: \.myCode, action: \.myCode))
      }
    })
  }
}

#if DEBUG
#Preview {
  NavigationView {
    ProfileView(store: .init(initialState: .init(myCode: .mock), reducer: Profile.init))
  }
}
#endif
