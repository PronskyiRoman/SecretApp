import ArchitectureTools
import DeviceHapticFeedbackService

extension SecretApp {
  func sendHapticFeedBack() -> Effect<Action> {
    @Dependency(\.deviceHapticFeedbackService) var service
    return .run(operation: { _ in
      try service.sendEvent(.simple)
    }, catch: { _, _ in
      // Handle Errors here if there any
    })
  }
}
