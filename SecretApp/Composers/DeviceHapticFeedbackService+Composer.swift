import ArchitectureTools
import DeviceHapticFeedbackService

extension DeviceHapticFeedbackService: @retroactive DependencyKey {
  public static var liveValue: Self = Composer.composed
}

private final class Composer {
  static var composed: DeviceHapticFeedbackService {
    .init(sendEvent: { event in
      switch event {
      case .simple: try IOSHapticService().sendSimpleEvent()
      }
    })
  }

  // We need to add a real listener for iOS here. so we will be able to listen
  // to iOS and iPad device Haptic
  // for mac os there will be different implementation that is why we are using generic type
  // with generic events for composing an app, without direct dependency on exact types
  final class IOSHapticService {
    func sendSimpleEvent() throws {
      // iOS Event
    }
  }
}
