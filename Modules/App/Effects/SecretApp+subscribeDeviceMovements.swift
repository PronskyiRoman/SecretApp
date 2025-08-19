import ArchitectureTools
import DeviceMovementsService

extension SecretApp {
  func subscribeDeviceMovements() -> Effect<Action> {
    @Dependency(\.deviceMovementsService) var service
    return.run { send in
      await service.subscribe { item in
        await send(.internal(.didReceiveDeviceMovement))
        await send(.internal(.didRequestHapticFeedback))
      }
    }
  }
}

// MARK: Mock Implementation for Confirmation of Correct set up
extension SecretApp {
  func sendDeviceMovement() -> Effect<Action> {
    @Dependency(\.deviceMovementsService) var service
    @Dependency(\.mainQueue) var queue
    return.run { send in
      try? await queue.sleep(for: .seconds(3))
      service.sendEvent(.didReceiveMovement)
    }
  }
}
