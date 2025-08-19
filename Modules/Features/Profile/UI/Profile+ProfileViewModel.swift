import Profile

extension Profile.State {
  var viewModel: ProfileViewModel {
    .init(
      codeScannerTitle: Localized.scan,
      myCodeTitle: Localized.myCode,
      isSelected: { $0 == selectedSegment }
    )
  }
}
