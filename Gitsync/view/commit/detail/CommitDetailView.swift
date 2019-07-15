import Cocoa
import Hybrid_macOS

open class CommitDetailView: NSView {
   override open var isFlipped: Bool { return true }/* TopLeft orientation */
   lazy var backButton: Button = createBackButton()
   lazy var repoNameLabel: NSLabel = createRepoNameLabel()
   lazy var titleLabel: NSLabel = createTitleLabel()
   lazy var descriptionLabel: NSLabel = createDescriptionLabel()
   
   override public init(frame: CGRect) {
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
//      self.layer?.backgroundColor = NSColor.green.cgColor
      _ = backButton
      _ = repoNameLabel
      _ = titleLabel
      _ = descriptionLabel
   }
   /**
    * Boilerplate
    */
   required public init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
