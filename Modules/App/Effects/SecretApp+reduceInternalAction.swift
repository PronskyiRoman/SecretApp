import ArchitectureTools

extension SecretApp {
  internal func reduce(into state: inout State, action: InternalAction) -> Effect<Action> {
    switch action {
    case .didReceiveDeviceMovement:
      state.path.append(.codeScanner(.init()))

    case .didRequestHapticFeedback:
      return sendHapticFeedBack()
    }

    return .none
  }
}

