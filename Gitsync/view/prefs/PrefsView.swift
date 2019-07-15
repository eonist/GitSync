import Cocoa
/**
 * PrefsView
 */
class PrefsView: NSView {
//   lazy var backButton: BackButton = createBackButton()
//   lazy var prefsList: PrefsList = createPrefsList()
   init() {
      super.init(frame: .zero)
//      _ = backButton
//      _ = prefsList
   }
   /**
    * Boilerplate
    */
   required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
