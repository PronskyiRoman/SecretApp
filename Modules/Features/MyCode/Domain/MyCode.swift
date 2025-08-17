import ArchitectureTools

@Reducer
public struct MyCode {
  @ObservableState
  public struct State {
    public init() {}
  }

  @CasePathable
  public enum Action {
    case didAppear
  }

  public init() {}

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      .none
    }
  }
}
