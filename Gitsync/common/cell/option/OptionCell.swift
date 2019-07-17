import Cocoa
import With_mac
import Hybrid_macOS
/**
 * Fixme: use OptionInput
 */
class OptionCell: BaseCell {
   lazy var descriptionLabel: NSLabel = createDescriptionLabel()
   lazy var checkButton: CheckButton = createCheckBox()
   /**
    * When you set the data, the diferent UI's will be updated
    */
   override var data: CellDataKind? {
      didSet {
         Swift.print("StaticTextCell.didSetData")
         self.layer?.backgroundColor = NSColor.orange.cgColor
         guard let data: OptionCellData = data as? OptionCellData else { fatalError("wrong data type") }
         Swift.print("data.staticText: \(data.staticText)")
         descriptionLabel.text = data.staticText
         checkButton.selected = data.isSelected
//         _ = checkButton
         //_ = descriptionLabel
      }
   }
}
