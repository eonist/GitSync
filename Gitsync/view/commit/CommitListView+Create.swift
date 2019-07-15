import Cocoa
import Spatial_macOS
import With_mac
/**
 * Create
 */
extension CommitListView {
   /**
    * CommitList
    */
   func createCommitList() -> CommitList {
      //let dataProvider: CommitDataProvider = .init(path: "commitList.json")
      let rowData = ["John", "Douglas", "Alba", "Albert", "Ben", "Laura", "James", "Amanda", "Cheryl", "Macey"]
      let list: CommitList = .init(rowData: rowData, frame: .zero)
      addSubview(list)
      list.anchorAndSize(to: self)
      //MacOS has strange default compression priorities: https://stackoverflow.com/questions/39013002/why-adding-constraints-removes-the-ability-to-resize-nswindow
      //      list.setContentCompressionResistancePriority(NSLayoutConstraint.Priority(rawValue: 249), for: NSLayoutConstraint.Orientation.horizontal)
      //      list.setContentCompressionResistancePriority(NSLayoutConstraint.Priority(rawValue: 249), for: NSLayoutConstraint.Orientation.vertical)
      return list
   }
}
