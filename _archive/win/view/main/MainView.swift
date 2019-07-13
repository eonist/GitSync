/**
 * MainView
 */
class MainView: NSView {
	lazy var commitList: CommitList = createCommitList()
	lazy var prefsButton: PrefsButton = createPrefsButton()
	init(){
		_ = commitList
		_ = prefsButton
	}
}
