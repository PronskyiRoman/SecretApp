import SwiftUI
import ArchitectureTools
import App
import ProfileUI
import ScannerUI
import MyCodeUI

class AppViewController: NavigationStackController {
  private var store: StoreOf<SecretApp>!

  convenience init(store: StoreOf<SecretApp>) {
    @UIBindable var store = store

    self.init(
      path: $store.scope(state: \.path, action: \.path),
      root: { ProfileView(store: store.scope(state: \.rootScreenState, action: \.root)).asController },
      destination: { store in
        switch store.case {
        case let .codeScanner(store):
          ScannerView(store: store).asController
        case let .myCode(store):
          MyCodeView(store: store).asController
        }
      })

    self.store = store
  }
}
