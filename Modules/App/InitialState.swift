import MyCodeUI

extension SecretApp {
  // since this screen should not be root screen of the App,
  // but we want it to we are setting a mock implementation here
  // created for UI
  public static let initialState: SecretApp.State = .init(root: .init(myCode: .mock))
}
