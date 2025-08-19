import ArchitectureTools
import MyCode
import Scanner

@Reducer
public enum Screen {
  case codeScanner(CodeScanner)
  case myCode(MyCode)
}

extension Screen.State: Equatable {}
