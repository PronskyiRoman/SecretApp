import ArchitectureTools

public struct DeviceMovementsService {
  public typealias Subscription = (_ handleEvent: (Event) async -> Void) async -> Void
  public typealias SendEvent = (Event) -> Void

  public enum Event {
    case didReceiveMovement
  }

  public let subscribe: Subscription
  public let sendEvent: SendEvent

  public init(subscribe: @escaping Subscription, sendEvent: @escaping SendEvent) {
    self.subscribe = subscribe
    self.sendEvent = sendEvent
  }
}

extension DeviceMovementsService: TestDependencyKey {
  public static let testValue = alwaysSucceeds()
}

extension DependencyValues {
  public var deviceMovementsService: DeviceMovementsService {
      get { self[DeviceMovementsService.self] }
      set { self[DeviceMovementsService.self] = newValue }
  }
}

public extension DeviceMovementsService {
  static func alwaysSucceeds() -> Self {
    .init(subscribe: { _ in }, sendEvent: { _ in })
  }
}
