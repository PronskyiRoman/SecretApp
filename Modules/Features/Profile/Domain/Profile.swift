import ArchitectureTools
import Scanner
import MyCode

@Reducer
public struct Profile {
  @CasePathable
  public enum Segment: Hashable {
    case codeScanner
    case myCode
  }

  @ObservableState
  public struct State {
    public var scanner: CodeScanner.State
    public var myCode: MyCode.State
    public var selectedSegment: Segment

    public init(
      scanner: CodeScanner.State = .init(),
      myCode: MyCode.State,
      selectedSegment: Segment = .myCode
    ) {
      self.myCode = myCode
      self.scanner = scanner
      self.selectedSegment = selectedSegment
    }
  }

  @CasePathable
  public enum Action: ViewAction {
    case scanner(CodeScanner.Action)
    case myCode(MyCode.Action)
    case view(Internal)

    @CasePathable
    public enum Internal {
      case didSelect(Segment)
    }
  }

  public init() {}

  public var body: some Reducer<State, Action> {
    Scope(state: \.scanner, action: \.scanner, child: CodeScanner.init)
    Scope(state: \.myCode, action: \.myCode, child: MyCode.init)

    Reduce { state, action in
      switch action {
      case .view(.didSelect(.myCode)):
        state.selectedSegment = .myCode
      case .view(.didSelect(.codeScanner)):
        state.selectedSegment = .codeScanner

      default:
        break
      }

      return .none
    }
  }
}
