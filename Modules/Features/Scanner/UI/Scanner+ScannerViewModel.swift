import Scanner

extension CodeScanner.State {
  var viewModel: ScannerViewModel {
    .init(
      navigationTitle: Localized.navigationTitle,
      openGalleryButtonTitle: Localized.openGallery,
      openGalleryButtonIcon: .eyeOn,
      enableFlashlightButtonTitle: Localized.flashLight,
      enableFlashlightButtonIcon: .flashLight
    )
  }
}
