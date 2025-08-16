import SwiftUI
import ArchitectureTools
import App
import ScannerUI
import MyCodeUI

class AppViewController: UINavigationController {
  let store: StoreOf<SecretApp>

  init(store: StoreOf<SecretApp>) {
    self.store = store
    super.init(nibName: nil, bundle: nil)
    setUp()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setUp() {
    observe { [weak self] in
      guard let self else { return }
      switch store.case {
      case let .myCode(store):
        setViewControllers([MyCodeView(store: store).asController], animated: false)
      case let .codeScanner(store):
        setViewControllers([ScannerView(store: store).asController], animated: false)
      }
    }
  }
}
