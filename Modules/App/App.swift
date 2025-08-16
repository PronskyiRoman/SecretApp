import ArchitectureTools
import Scanner
import MyCode

@Reducer
public enum SecretApp {
  case codeScanner(CodeScanner)
  case myCode(MyCode)

  public static var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      default:
        break
      }

      return .none
    }
    .ifCaseLet(\.codeScanner, action: \.codeScanner, then: CodeScanner.init)
    .ifCaseLet(\.myCode, action: \.myCode, then: MyCode.init)
  }
}

extension SecretApp.State: Equatable {}
