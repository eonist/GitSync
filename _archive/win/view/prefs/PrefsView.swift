/**
 * PrefsView
 */
class PrefsView: NSView {
	lazy var backButton: BackButton = createBackButton()
	lazy var prefsList: PrefsList = createPrefsList()
	init() {
		_ = backButton
		_ = prefsList
	}
}
