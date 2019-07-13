import Foundation
/*
 * ComboboxInputCell
 */
class ComboboxInputCell: NSTableCell {
	lazy var titleLabel: NSLabel = createTitleLabel()
	lazy var comboBox: NSLabel = createComboBox()
	var data: CellDataKind {
		didSet {
			let data: ComboBoxInputData = data as CheckBoxInputData
			titleLabel.setText(data.title)
			comboBox.selections = data.selections
		}
	}
}
/**
 * Create
 */
extension ComboboxInputCell{
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
	func createComboBox() -> ComboBox {
		return with(.init()){
			$0.anchorAndSize(to:self,size:.init(width:124,height:24), align: .centerRight, alignTo: .centerRight, offset: .init(x:-12,y:0))
			self.addSubview($0)
		}
	}
}
