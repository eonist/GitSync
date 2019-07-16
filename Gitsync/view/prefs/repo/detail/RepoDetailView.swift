import Cocoa
import Hybrid_macOS
/**
 * RepoDetailView
 */
open class RepoDetailView: NSView {
   override open var isFlipped: Bool { return true } /* TopLeft orientation */
   lazy var backButton: Button = createBackButton()
   lazy var repoDetailList: RepoDetailList = createRepoDetailList()
   
   override public init(frame: CGRect) {
      Swift.print("RepoDetailView")
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
      self.layer?.backgroundColor = NSColor.white.cgColor
      _ = backButton
      _ = repoDetailList
   }
   /**
    * Boilerplate
    */
   required public init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
