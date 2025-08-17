import ArchitectureTools
import Profile

@Reducer
public struct SecretApp {
  @ObservableState
  public struct State {
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
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Scope(state: \.rootScreenState, action: \.root, child: Profile.init)

    Reduce { state, action in
      .none
    }
  }
}
