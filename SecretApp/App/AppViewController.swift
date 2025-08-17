import SwiftUI
import ArchitectureTools
import App
import ProfileUI

class AppViewController: UINavigationController {
  @UIBindable var store: StoreOf<SecretApp>

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
      setViewControllers([ProfileView(store: store.scope(state: \.rootScreenState, action: \.root)).asController], animated: false)
    }
  }
}
