import SwiftUI

extension View {
  var asController: UIViewController {
    UIHostingController(rootView: self)
  }
}
