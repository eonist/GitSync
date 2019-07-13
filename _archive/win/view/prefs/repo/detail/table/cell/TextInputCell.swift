import Foundation
/*
 * ComboboxInputCell
 */
class TextInputCell: NSTableCell {
	lazy var titleLabel: NSLabel = createTitleLabel()
	lazy var inputTextField: NSTextField = creatInputeTextField()
	var data: CellDataKind {
		didSet {
			let data: ComboBoxInputData = data as CheckBoxInputData
			titleLabel.setText(data.title)
			inputTextField.setText(data.inputText)
		}
	}
}
/**
 * Create
 */
extension TextInputCell{
	/*
    * TitleLabel
    */
	func createTitleLabel() -> NSLabel {
		return with(.init()){
			$0.anchorAndSize()
			addsubview($0)
		}
	}
	/*
    * ComboBox
    */
	func creatInputeTextField() -> TextField {
		return with(.init()){
			$0.anchorAndSize(to:self,size:.init(width:124,height:24), align: .centerRight, alignTo: .centerRight, offset: .init(x:-12,y:0))
			$0.backgroundColor = .gray
			self.addSubview($0)
		}
	}
}
