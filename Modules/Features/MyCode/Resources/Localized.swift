public enum Localized {
  public static let copyAddress = "Address copied"
  public static let navigationTitle = "Receive"
  public static func destination(networks: [String]) -> String {
    guard !networks.isEmpty else {
      return "To send, use Alien network only"
    }

    return "To send, use \(networks.joined(separator: " or ")) network only"
  }
}
