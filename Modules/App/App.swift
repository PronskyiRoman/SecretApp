import ArchitectureTools
import Profile
import MyCode
import Scanner

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
  public enum Action {
    case appDelegate(AppDelegateAction)
    case root(Profile.Action)
    case path(StackActionOf<Screen>)
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Scope(state: \.rootScreenState, action: \.root, child: Profile.init)

    Reduce { state, action in
      .none
    }
    .forEach(\.path, action: \.path)
  }
}

extension SecretApp.Screen.State: Equatable {}
