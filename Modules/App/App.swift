import ArchitectureTools
import Profile
import MyCode
import Scanner
import DeviceHapticFeedbackService
import DeviceMovementsService

@Reducer
public struct SecretApp {
  @Reducer
  public enum Screen {
    case codeScanner(CodeScanner)
    case myCode(MyCode)
  }

  @ObservableState
  public struct State {
    public var path = StackState<Screen.State>()
    public var rootScreenState: Profile.State

    public init(root: Profile.State) {
      rootScreenState = root
    }
  }

  @CasePathable
  public enum AppDelegateAction {
    case didFinishLaunching
  }

  @CasePathable
  public enum InternalAction {
    case didReceiveDeviceMovement
    case didRequestHapticFeedback
  }

  @CasePathable
  public enum Action {
    case appDelegate(AppDelegateAction)
    case `internal`(InternalAction)
    case root(Profile.Action)
    case path(StackActionOf<Screen>)
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Scope(state: \.rootScreenState, action: \.root, child: Profile.init)

    Reduce { state, action in
      switch action {
      case .path(.element(id: _, action: .codeScanner(.view(.didTapBack)))):
        state.path.removeLast()

      case .appDelegate(.didFinishLaunching):
        return .merge(
          subscribeDeviceMovements(),
          sendDeviceMovement()
        )

      case .internal(.didReceiveDeviceMovement):
        state.path.append(.codeScanner(.init()))

      case .internal(.didRequestHapticFeedback):
        return sendHapticFeedBack()

      default: break
      }

      return .none
    }
    .forEach(\.path, action: \.path)
  }
}

extension SecretApp.Screen.State: Equatable {}

private extension SecretApp {
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

private extension SecretApp {
  func sendHapticFeedBack() -> Effect<Action> {
    @Dependency(\.deviceHapticFeedbackService) var service
    return .run(operation: { _ in
      try service.sendEvent(.simple)
    }, catch: { _, _ in
      // Handle Errors here if there any
    })
  }
}

// MARK: Private implementation to confirm that navigation works properly
private extension SecretApp {
  func sendDeviceMovement() -> Effect<Action> {
    @Dependency(\.deviceMovementsService) var service
    @Dependency(\.mainQueue) var queue
    return.run { send in
      try? await queue.sleep(for: .seconds(3))
      service.sendEvent(.didReceiveMovement)
    }
  }
}
