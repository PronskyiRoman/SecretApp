import Scanner
import ArchitectureTools
import SwiftUI

public struct ScannerView: View {
  let store: StoreOf<CodeScanner>

  public init(store: StoreOf<CodeScanner>) {
    self.store = store
  }

  public var body: some View {
    Text("Hello, ScannerUI")
  }
}
