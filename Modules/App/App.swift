import ArchitectureTools
import Profile

@Reducer
public struct SecretApp {
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
      case let .path(.element(id: _, action: .codeScanner(action))):
        return reduce(into: &state, action: action)

      case .appDelegate(.didFinishLaunching):
        return didFinishLaunch()

      case let .internal(action):
        return reduce(into: &state, action: action)

      default: break
      }

      return .none
    }
    .forEach(\.path, action: \.path)
  }
}
