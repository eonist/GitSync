/**
 * Create
 */
extension PrefsView {
	/**
    * BackButton
    */
	func createBackButton() -> BackButton {
		return with(.init()) {
			$0.anchorAndSize(to: self, align:.topLeft, alignTo: topLeft, size: .init(width: 96, height: 32), offset: .init(x:6,y:8))
			$0.setText("Back")
			$0.onClick = onBackButtonClick
			addSubview($0)
		}
	}
	/*
    * PrefsList
    */
	func createPrefsList() -> PrefsList {
		return with(.init()) {
			$0.anchorAndSize(to: self, align:.topLeft, alignTo: topLeft, sizeOffset: .init(width: 0, height: -44), offset: .init(x:0,y:44))
			addSubview($0)
		}
	}
}
