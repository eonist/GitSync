import Cocoa
import Spatial_macOS
import With_mac
import Hybrid_macOS
/**
 * Create
 */
extension CommitListView {
   /**
    * PrefsBtn
    */
   func cratePrefsBtn() -> TextButton {
      return with(.init(text: "Prefs", style: TextButton.defaultTextButtonStyle, frame: .zero)) {
         $0.textLabel.font = .systemFont(ofSize: 14)
         $0.textLabel.centerVertically()
         addSubview($0)
         $0.anchorAndSize(to: self, width: 72, height: 24, align: .topLeft, alignTo: .topLeft, offset: .init(x: 12, y: 6))
         $0.upInsideCallBack = onPrefsButtonClick
      }
   }
   /**
    * CommitList
    */
   func createCommitList() -> CommitList {
      //let dataProvider: CommitDataProvider = .init(path: "commitList.json")
      let rowData = ["John", "Douglas", "Alba", "Albert", "Ben", "Laura", "James", "Amanda", "Cheryl", "Macey"]
      let list: CommitList = .init(rowData: rowData, frame: .zero)
      addSubview(list)
      list.anchorAndSize(to: prefsButton, sizeTo: self, align: .topLeft, alignTo: .bottomLeft, offset: .init(x: -12, y: 6), sizeOffset: .init(width: 0, height: -(24 + 6 + 6)))
      // MacOS has strange default compression priorities: https://stackoverflow.com/questions/39013002/why-adding-constraints-removes-the-ability-to-resize-nswindow
      //      list.setContentCompressionResistancePriority(NSLayoutConstraint.Priority(rawValue: 249), for: NSLayoutConstraint.Orientation.horizontal)
      //      list.setContentCompressionResistancePriority(NSLayoutConstraint.Priority(rawValue: 249), for: NSLayoutConstraint.Orientation.vertical)
      return list
   }
}
