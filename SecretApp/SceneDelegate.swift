import SwiftUI
import ArchitectureTools
import App

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  let store = Store(initialState: SecretApp.initialState) {
    SecretApp()._printChanges()
  }

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: scene)
    configureWindow()
    didFinishConfiguration()
  }

  func configureWindow() {
    window?.makeKeyAndVisible()
    window?.rootViewController = AppViewController(store: store)
  }

  func didFinishConfiguration() {
    store.send(.appDelegate(.didFinishLaunching))
  }
}
