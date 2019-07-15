import Cocoa
import Hybrid_macOS
import With_mac
/**
 * Create
 */
extension CommitDetailView {
   /**
    * BackButton
    */
   func createBackButton() -> TextButton {//(style: TextButton.defaultStyle, frame: .zero))
      return with(.init(text: "Back", style: TextButton.defaultTextButtonStyle, frame: .zero)) {
         $0.textLabel.font = .systemFont(ofSize: 14)
         $0.textLabel.centerVertically()
         addSubview($0)
         $0.anchorAndSize(to: self, width: 72, height: 24, align: .topLeft, alignTo: .topLeft, offset: .init(x: 12, y: 8))
         $0.upInsideCallBack = onBackButtonClick
      }
   }
   /**
    * RepoNameLabel
    */
   func createRepoNameLabel() -> NSLabel {
      return with(.init()) {/*string: repoName*/
         $0.text = "GitSync"
         $0.centerVertically()
         $0.textAlignment = .left
         $0.textColor = .gray
         self.addSubview($0)
         $0.anchorAndSize(to: backButton, sizeTo: self, height: 24, align: .topLeft, alignTo: .bottomLeft, offset: .init(x:0, y: 4))
      }
   }
   /**
    * TitleLabel
    */
   func createTitleLabel() -> NSLabel {
      return with(.init()) {
         $0.text = "Files modified: 1"
         $0.textAlignment = .left
//         $0.textColor = .black
         $0.font = .systemFont(ofSize: 20)
         $0.centerVertically()
         self.addSubview($0)
         $0.anchorAndSize(to: repoNameLabel, sizeTo: self, height:32, align: .topLeft, alignTo: .bottomLeft, offset: .init(x:0,y:0))
         addSubview($0)
      }
   }
   /**
    * DescriptionLabel
    */
   func createDescriptionLabel() -> NSLabel {
      return with(.init()) {
         $0.text = "Files modified: 1 \nFile gitsync/Gitsync.swift was \nReflect the change in the parent"
         $0.textAlignment = .left
         $0.textColor = .gray
         self.addSubview($0)
//         $0.translatesAutoresizingMaskIntoConstraints = false
         $0.anchorAndSize(to: titleLabel, sizeTo: self, align: .topLeft, alignTo: .bottomLeft,  offset: .init(x:0,y:0), sizeOffset: .init(width:0, height:-24-32))
         //MacOS has strange default compression priorities: https://stackoverflow.com/questions/39013002/why-adding-constraints-removes-the-ability-to-resize-nswindow
      }
   }
}
