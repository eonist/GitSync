class PrefsButton: NSView {
	lazy var icon: NSView = createIcon
	lazy var background: NSView = createBg()
	init(){
		_ = backgroun
		_ = icon
	}
	func createBg() -> NSView {
		return with(.init()) {
			.background = .gray
			.roundedCorner = 24
		}
	}
	func createIcon() -> NSView{
		// draw 3 lines or dots
		return .init()
	}
}
