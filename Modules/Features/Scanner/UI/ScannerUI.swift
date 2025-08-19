import Scanner
import ArchitectureTools
import SwiftUI
import DesignSystem

@ViewAction(for: CodeScanner.self)
public struct ScannerView: View {
  public let store: StoreOf<CodeScanner>

  public init(store: StoreOf<CodeScanner>) {
    self.store = store
  }

  public var body: some View {
    content
  }
}

private extension ScannerView {
  var content: some View {
    cameraView
      .overlay(content: {
        GeometryReader { geo in
          WithPerceptionTracking(content: {
            ZStack {
              qrCodeScannerHood
              buttons
                .offset(y: geo.size.height / 5)
            }
          })
        }
      })
      .toolbar { toolbar }
      .navigationBarBackButtonHidden()
  }

  var qrCodeScannerHood: some View {
    Color
      .bgTertiary
      .ignoresSafeArea()
  }

  var cameraView: some View {
    Image(.screenOfCamera)
      .resizable()
      .scaledToFill()
      .ignoresSafeArea()
  }

  @ToolbarContentBuilder
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .principal) {
      navigationTitle
    }

    ToolbarItem(placement: .confirmationAction) {
      closeButton
    }
  }

  var navigationTitle: some View {
    Text(store.viewModel.navigationTitle)
      .foregroundStyle(.textPrimary)
      .font(.paragraphMedium)
  }

  var closeButton: some View {
    Button {
      send(.didTapBack)
    } label: {
      Asset.cross.swiftUIImage
    }
  }

  var buttons: some View {
    HStack(alignment: .center, spacing: .zero) {
      button(store.viewModel.openGalleryButtonTitle,
             image: store.viewModel.openGalleryButtonIcon.swiftUIImage,
             action: { send(.didTapOpenGallery) })
      button(store.viewModel.enableFlashlightButtonTitle,
             image: store.viewModel.enableFlashlightButtonIcon.swiftUIImage,
             action: { send(.didTapFlashlight) })
    }
  }

  func button(_ title: String, image: Image, action: @escaping () -> Void) -> some View {
    Button(action: action, label: {
      VStack(spacing: 4) {
        image
        Text(title)
          .foregroundStyle(.textPrimary)
          .font(.labelXSmall)
      }
      .padding(.horizontal, 32)
      .clipShape(.rect)
    })
  }
}

#if DEBUG
#Preview {
  NavigationView {
    ScannerView(store: .init(initialState: .init(), reducer: CodeScanner.init))
  }
}
#endif

