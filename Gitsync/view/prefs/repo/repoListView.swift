import Cocoa
import Hybrid_macOS
/**
 * PrefsView
 */
open class RepoListView: NSView {
   override open var isFlipped: Bool { return true }/* TopLeft orientation */
   lazy var backButton : Button  = createBackButton()
   lazy var addRepoButton: Button = createAddRepoButton()
   lazy var repoList: RepoList = createRepoList()
   /**
    * Init
    */
   override public init(frame: CGRect) {
      Swift.print("RepoListView")
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
      self.layer?.backgroundColor = NSColor.white.cgColor
      _ = backButton
      _ = addRepoButton
      _ = repoList
   }
   /**
    * Boilerplate
    */
   required public init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
