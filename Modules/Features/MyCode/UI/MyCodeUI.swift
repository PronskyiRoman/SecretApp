import MyCode
import ArchitectureTools
import SwiftUI
import DesignSystem

@ViewAction(for: MyCode.self)
public struct MyCodeView: View {
  public let store: StoreOf<MyCode>

  public init(store: StoreOf<MyCode>) {
    self.store = store
  }

  public var body: some View {
    content
  }
}

private extension MyCodeView {
  var content: some View {
    VStack {
      name
        .padding(.top, 32)
      qrCode
        .padding(.vertical, 24)
      coinsImages
      coinsLabel
        .padding(.vertical, 4)
      destinationNetwork
      address
        .padding(.top, 12)
      Spacer()
    }
    .navigationBarBackButtonHidden()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background { background }
    .toolbar { toolbar }
  }

  @ToolbarContentBuilder
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .principal) {
        toolbarPrincipalSection
    }

    ToolbarItem(placement: .confirmationAction) {
        closeButton
    }

    ToolbarItem(placement: .cancellationAction) {
        shareButton
    }
  }

  @ViewBuilder
  var toolbarPrincipalSection: some View {
    if store.viewModel.isCopied {
      copyLabel
    } else {
      navigationTitle
    }
  }

  var navigationTitle: some View {
    Text(store.viewModel.navigationTitle)
      .foregroundStyle(.textPrimary)
      .font(.paragraphMedium)
  }

  var copyLabel: some View {
    HStack(alignment: .center, spacing: 6) {
      Asset.checkMark.swiftUIImage
      Text(store.viewModel.copyLabel)
        .foregroundStyle(.textPrimary)
        .font(.paragraphMedium)
    }
    .padding(.init(top: 6, leading: 6, bottom: 6, trailing: 12))
    .background(.buttonPrimaryBgActive)
    .cornerRadius(16)
  }

  var closeButton: some View {
    Button {
      send(.didTapClose)
    } label: {
      Asset.cross.swiftUIImage
    }
  }

  var shareButton: some View {
    Button {
      send(.didTapShare)
    } label: {
      Asset.share.swiftUIImage
    }
  }

  var background: some View {
    Color
      .bgPrimary
      .ignoresSafeArea()
  }

  @ViewBuilder
  var coinsImages: some View {
    let images = store.viewModel.coinsImages
      .map({ $0 })
      .compactMap({ UIImage(data: $0) })

    HStack(alignment: .center, spacing: .zero) {
      ForEach(images.indices, id: \.self) { index in
        background
          .frame(width: 26, height: 26)
          .clipShape(.circle)
          .overlay {
            Image(uiImage: images[index])
              .resizable()
              .frame(width: 24, height: 24)
          }
          .offset(x: index == 0 ? 0 : -(Double(index) * 10))
      }
    }
  }

  var coinsLabel: some View {
    Text(store.viewModel.coinsLabel)
      .font(.paragraphMedium)
      .foregroundStyle(.textPrimary)
  }

  var destinationNetwork: some View {
    Text(store.viewModel.destinationNetwork)
      .font(.labelTiny)
      .foregroundStyle(.textSecondary)
  }

  @ViewBuilder
  var qrCode: some View {
    if let image = UIImage(data: store.viewModel.QRImage) {
      Image(uiImage: image)
        .resizable()
        .frame(width: 302, height: 302)
    } else {
      Color.clear
        .frame(width: 302, height: 302)
    }
  }

  var name: some View {
    Text(store.viewModel.name)
      .font(.paragraphLarge)
      .gradientForeground(colors: [.gradientStart, .gradientEnd])
      .frame(maxWidth: .infinity, alignment: .center)
  }

  var address: some View {
    Button {
      send(.didTapCopy, animation: .default)
    } label: {
      HStack(alignment: .center, spacing: 8) {
        Text(store.viewModel.address)
          .truncationMode(.middle)
          .font(.labelSmall)
          .foregroundStyle(.textPrimary)
          .frame(width: 187)
        Asset.copy.swiftUIImage
      }
      .padding(.init(top: 8, leading: 12, bottom: 8, trailing: 12))
      .background(.alphaNeutralAlpha16)
      .cornerRadius(16)
    }
  }
}

private extension View {
  func gradientForeground(colors: [Color]) -> some View {
    self.overlay(
      LinearGradient(
        colors: colors,
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    )
    .mask(self)
  }
}

#if DEBUG
public extension MyCode.State {
  static let mock: Self = .init(
    name: "@kirillavery",
    coins: [
      .init(title: "Aliencoin", image: { Asset.coins_v1.uiImage.pngData()! }()),
      .init(title: "Solana", image: { Asset.coins_v2.uiImage.pngData()! }()),
      .init(title: "US Dollar", image: { Asset.coins_v3.uiImage.pngData()! }()),
    ],
    address: "8TZLxqVmNf3...zAYnbtQgXp",
    networks: ["Solana", "Alien"],
    qrCode: UIImage(resource: .QR).pngData()!
  )
}

#Preview {
  NavigationView {
    MyCodeView(store: .init(
      initialState: .mock,
      reducer: MyCode.init))
  }
}
#endif
