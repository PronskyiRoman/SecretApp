import ArchitectureTools

@Reducer
public struct CodeScanner {
  @ObservableState
  public struct State {
    public init() {}
  }

  @CasePathable
  public enum Action: ViewAction {
    case view(ViewAction)

    @CasePathable
    public enum ViewAction {
      case didTapOpenGallery
      case didTapFlashlight
      case didTapBack
    }
  }

  public init() {}

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      .none
    }
  }
}
