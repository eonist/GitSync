import Cocoa
import With_mac
import Hybrid_macOS
/**
 * - Abstract: Provides a way to show a DescriptionLabel and and InputTextField in a TableCell
 * - Description: Left-aligned Label and Right-Aligned content TextField
 */
class TextCell: BaseCell {
   lazy var descriptionLabel: NSLabel = createDescriptionLabel()
   lazy var contentTextField: NSTextField = createContentTextField()
   /**
    * When you set the data, the diferent UI's will be updated
    */
   override var data: CellDataKind? {
      didSet {
         guard let data: TextCellData = data as? TextCellData else { fatalError("incorrect data type") }
         descriptionLabel.text = data.staticText
         contentTextField.stringValue = data.dynamicText
      }
   }
}

