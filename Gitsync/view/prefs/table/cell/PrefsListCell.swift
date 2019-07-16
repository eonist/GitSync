import Cocoa
import With_mac
import Hybrid_macOS

class CheckBoxInputCell: NSTableCellView {
   let repoName: String
   lazy var repoNameLabel: NSLabel = createRepoNameLabel()
   lazy var titleLabel: NSLabel = createTitleLabel()
   lazy var descriptionLabel: NSLabel = createDescriptionLabel()
   lazy var authorLabel: NSLabel = createAuthorLabel()
   lazy var dateLabel: NSLabel = createDateLabel()
   /**
    * Init
    */
   init(frame frameRect: NSRect, repoName: String) {
      self.repoName = repoName
      super.init(frame: frameRect)
      _ = repoNameLabel
      _ = titleLabel
      _ = descriptionLabel
      _ = authorLabel
      _ = dateLabel
      
   }
   /**
    * Boilerplate
    */
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
