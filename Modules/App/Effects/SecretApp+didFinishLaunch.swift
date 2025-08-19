import ArchitectureTools

extension SecretApp {
  public func didFinishLaunch() -> Effect<Action> {
    .merge(
      subscribeDeviceMovements(),
      sendDeviceMovement()
    )
  }
}
