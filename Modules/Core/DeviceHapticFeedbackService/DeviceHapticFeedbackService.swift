import ArchitectureTools

public struct DeviceHapticFeedbackService {
  public typealias SendEvent = (Event) throws -> Void
  public enum Event {
    case simple
  }

  public let sendEvent: SendEvent

  public init(sendEvent: @escaping SendEvent) {
    self.sendEvent = sendEvent
  }
}

extension DeviceHapticFeedbackService: TestDependencyKey {
   public static let testValue = alwaysSucceeds()
}

extension DependencyValues {
  public var deviceHapticFeedbackService: DeviceHapticFeedbackService {
      get { self[DeviceHapticFeedbackService.self] }
      set { self[DeviceHapticFeedbackService.self] = newValue }
  }
}

public extension DeviceHapticFeedbackService {
  static func alwaysSucceeds() -> Self {
    .init(sendEvent: { _ in })
  }
}
