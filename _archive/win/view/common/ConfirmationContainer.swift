/**
 * Simple way to add Ok and cancel buttons
 */
class ConfirmationContainer: NSView {
	lazy var okBUtton: NSButton = createOkButton
	lazy var cancelButton: NSButton = createCancelButton
	init(){
		_ = okButton
		_ = cancelButton
	}
}

extension ConfirmationContainer {
	/**
    * Create button
    */
	func createOkButton() -> Button {
		return with(.init()) {
			$0.anchorAndSize(to:self,align:.topLeft,alignTo:.bottomLeft, sizeMultiplier:.init(width:0.5,height:1),sizeOffset:.init(width:-12,height:0), offset:.init(x:0,y:12))
			addSubview($0)
		}
	}
	/**
    * Create button
    */
	func createCancelButton() -> Button {
		return with(.init()) {
			$0.anchorAndSize(to:self,align:.topRight,alignTo:.topRight, sizeMultiplier:.init(width:0.5,height:1),sizeOffset:.init(width:-12,height:0), offset:.init(x:0,y:12))
			addSubview($0)
		}
	}
}
