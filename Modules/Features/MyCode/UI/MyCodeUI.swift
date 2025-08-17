import MyCode
import ArchitectureTools
import SwiftUI

public struct MyCodeView: View {
  let store: StoreOf<MyCode>

  public init(store: StoreOf<MyCode>) {
    self.store = store
  }

  public var body: some View {
    ZStack {
      Color.orange
      Button("Hello, MyCodeUI") {
        store.send(.didAppear)
      }
    }
  }
}
