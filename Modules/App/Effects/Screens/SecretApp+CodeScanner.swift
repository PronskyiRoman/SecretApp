import ArchitectureTools
import Scanner

extension SecretApp {
  public func reduce(into state: inout State, action: CodeScanner.Action) -> Effect<Action> {
    switch action {
    case .view(.didTapBack):
      state.path.removeLast(1)

    default: break
    }

    return .none
  }
}
