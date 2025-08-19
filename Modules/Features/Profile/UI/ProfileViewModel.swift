import Profile

struct ProfileViewModel {
  let codeScannerTitle: String
  let myCodeTitle: String

  let isSelected: (Profile.Segment) -> Bool
}
