/**
 * CheckBoxInputCell
 */
class CheckBoxInputCell: NSTableCell {
	lazy var titleLabel: NSLabel = createTitleLabel()
	lazy var checkBox: NSLabel = createCheckBox()
	var data: CellDataKind {
		didSet {
			let data: CheckBoxInputData = data as CheckBoxInputData
			titleLabel.setText(data.title)
			checkBox.isSelected = data.isSelected
		}
	}
}
/**
 * Create
 */
extension CheckBoxInputCell {
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
    * CheckBox
    */
	func createCheckBox() -> CheckBox {
		return with(.init()){
			$0.anchorAndSize(to:self,size:.init(width:24,height:24), align: .centerRight, alignTo: .centerRight, offset: .init(x:-12,y:0))
			self.addSubview($0)
		}
	}
}
