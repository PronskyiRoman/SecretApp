import ArchitectureTools

@Reducer
public struct MyCode: Sendable {
  @ObservableState
  public struct State: Hashable {
    public init() {}
  }

  @CasePathable
  public enum Action: Sendable {
    case didAppear
  }

  public init() {}

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      return .none
    }
  }
}
