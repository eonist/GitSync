import Foundation
import With_mac
import Spatial_macOS

extension Nav {
   /**
    * CommitList
    */
   static func createCommitListView(view: NSView) -> CommitListView {
      return with( .init(frame: .zero)) {
         view.addSubview($0)
         $0.anchorAndSize(to: view)
      }
   }
   /**
    * CommitDetail
    */
   static func createCommitDetailView(view: NSView) -> CommitDetailView {
      return with( .init(frame: .zero)) {
         view.addSubview($0)
         $0.anchorAndSize(to: view, height: view.frame.size.height) // ⚠️️ the height is a quick hack
      }
   }
}
