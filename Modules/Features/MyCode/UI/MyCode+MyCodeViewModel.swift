import MyCode

extension MyCode.State {
  var viewModel: MyCodeViewModel {
    .init(
      navigationTitle: Localized.navigationTitle,
      address: address,
      name: name,
      coinsImages: coins.map(\.image),
      coinsLabel: coins.map(\.title).joined(separator: ", "),
      destinationNetwork: Localized.destination(networks: networks),
      QRImage: qrCode,
      copyLabel: Localized.copyAddress,
      isCopied: isCopied
    )
  }
}
