import Cocoa
import Hybrid_macOS
/**
 * CommitListView
 * - Fixme: ⚠️️ rename to CommitView
 */
open class CommitListView: NSView {
   override open var isFlipped: Bool { return true }/* TopLeft orientation */
   lazy var prefsButton: Button = cratePrefsBtn()
   lazy var commitList: CommitList = createCommitList()
   /**
    * Init
    */
   override public init(frame: CGRect) {
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
      self.layer?.backgroundColor = NSColor.white.cgColor
      _ = prefsButton
      _ = commitList
   }
   /**
    * Boilerplate
    */
   required public init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
