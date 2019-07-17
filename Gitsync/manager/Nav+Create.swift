import Foundation
import With_mac
import Spatial_macOS
/**
 * Commit related
 */
extension Nav {
   /**
    * CommitListView
    */
   static func createCommitListView(view: NSView) -> CommitListView {
      return with( .init(frame: .zero)) {
         view.addSubview($0)
         $0.anchorAndSize(to: view)
      }
   }
   /**
    * CommitDetailView
    */
   static func createCommitDetailView(view: NSView) -> CommitDetailView {
      return with( .init(frame: .zero)) {
         view.addSubview($0)
         $0.anchorAndSize(to: view, height: view.frame.size.height) // ⚠️️ the height is a quick hack
      }
   }
}
/**
 * Prefs related
 */
extension Nav {
   /**
    * PrefsListView
    */
   static func createPrefsListView(view: NSView) -> PrefsView {
      return with( .init(frame: .zero)) {
         view.addSubview($0)
         $0.anchorAndSize(to: view)
      }
   }
}
/**
 * Repo related
 */
extension Nav {
   /**
    * RepoListView
    */
   static func createRepoListView(view: NSView) -> RepoListView {
      return with( .init(frame: .zero)) {
         view.addSubview($0)
         $0.anchorAndSize(to: view)
      }
   }
   /**
    * RepoDetailView
    */
   static func createRepoDetailView(view: NSView) -> RepoDetailView {
      return with( .init(frame: .zero)) {
         view.addSubview($0)
         $0.anchorAndSize(to: view)
      }
   }
}
/**
 * Dialog related
 */
extension Nav {
   /**
    * CommitDialogView
    */
   static func createCommitDialogView(view: NSView) -> CommitDialogView {
      return with( .init(frame: .zero)) {
         view.addSubview($0)
         $0.anchorAndSize(to: view)
      }
   }
   /**
    * MergeConflictDialogView
    */
   static func createMergeConflictView(view: NSView) -> MergeConflictView {
      return with( .init(frame: .zero)) {
         view.addSubview($0)
         $0.anchorAndSize(to: view)
      }
   }
}
