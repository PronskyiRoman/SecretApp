import ArchitectureTools
import Foundation

@Reducer
public struct MyCode {
  public struct Coin: Equatable {
    public var title: String
    public var image: Data

    public init(title: String, image: Data) {
      self.title = title
      self.image = image
    }
  }

  @ObservableState
  public struct State: Equatable {
    public let name: String
    public let coins: [Coin]
    public let address: String
    public let networks: [String]
    public let qrCode: Data
    public private(set) var isCopied: Bool = false

    public init(
      name: String,
      coins: [Coin],
      address: String,
      networks: [String],
      qrCode: Data
    ) {
      self.name = name
      self.coins = coins
      self.address = address
      self.networks = networks
      self.qrCode = qrCode
    }
  }

  @CasePathable
  public enum InternalAction {
    case didDismissCopy
  }

  @CasePathable
  public enum Action: ViewAction {
    case `internal`(InternalAction)
    case view(ViewAction)

    public enum ViewAction {
      case didTapClose
      case didTapShare
      case didTapCopy
    }
  }

  public init() {}

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .view(.didTapCopy):
        state.toggleCopied(to: true)
        return .run { send in
          @Dependency(\.mainQueue) var mainQueue
          try await mainQueue.sleep(for: .seconds(2))
          await send(.internal(.didDismissCopy))
        }

      case .internal(.didDismissCopy):
        state.toggleCopied(to: false)

      default:
        break
      }

      return .none
    }
  }
}

private extension MyCode.State {
  mutating func toggleCopied(to newValue: Bool) {
    isCopied = newValue
  }
}
