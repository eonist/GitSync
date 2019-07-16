import Cocoa
import With_mac
import Hybrid_macOS
/**
 * - Abstract: Provides a way to show a DescriptionLabel and and InputTextField in a TableCell
 * - Description: Left-aligned Label and Right-Aligned content TextField
 */
class StaticTextCell: BaseCell {
   lazy var descriptionLabel: NSLabel = createDescriptionLabel()
   lazy var indicatorLabel: NSLabel = crateIndicatorLabel()
   /**
    * When you set the data, the diferent UI's will be updated
    */
   override var data: CellDataKind? {
      didSet {
         Swift.print("StaticTextCell.didSetData")
         self.layer?.backgroundColor = NSColor.orange.cgColor
         guard let data: StaticTextCellData = data as? StaticTextCellData else { fatalError("wrong data type") }
         Swift.print("data.staticText: \(data.staticText)")
         descriptionLabel.text = data.staticText
         _ = indicatorLabel
//         _ = descriptionLabel
      }
   }
}
