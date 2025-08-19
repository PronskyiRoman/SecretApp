import ArchitectureTools
import DeviceMovementsService

extension DeviceMovementsService: @retroactive DependencyKey {
  public static var liveValue: Self = Composer.composed
}

private final class Composer {
  static var composed: DeviceMovementsService {
    let listener = EventListener<DeviceMovementsService.Event>()
    return .init(
      subscribe: { handleEvent in
        for await value in listener.stream {
            await handleEvent(value)
        }
      },
      sendEvent: listener.yield)
  }

  // We need to add a real listener for iOS here. so we will be able to listen
  // to iOS and iPad device movements
  // for mac os there will be different implementation that is why we are using generic type
  // with generic events
  final class IOSMovementsDelegate {
    func didReceiveAnSystemEvent() {
      @Dependency(\.deviceMovementsService) var service
      service.sendEvent(.didReceiveMovement)
    }
  }
}
