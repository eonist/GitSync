import Cocoa
import With_mac
import Spatial_macOS
import Hybrid_macOS
/**
 * Create
 */
extension CommitCell {
   /**
    * RepoNameLabel
    */
   func createRepoNameLabel() -> NSLabel {
      return with(.init()) {/*string: repoName*/
         $0.text = "GitSync"
         $0.textColor = .gray
         $0.centerVertically()
         $0.textAlignment = .left
         self.addSubview($0)
         self.textField = $0 // Fixme: rather remove self.textField and dont add
         $0.anchorAndSize(to: self, height:24, align: .topLeft, alignTo: .topLeft, offset: .init(x:12,y:0))
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
    * Description
    */
   func createDescriptionLabel() -> NSLabel {
      return with(.init()) {
         $0.text = "Files modified: 1 \nFile gitsync/Gitsync.swift was \nReflect the change in the parent"
         $0.textAlignment = .left
         $0.textColor = .gray
         self.addSubview($0)
         $0.anchorAndSize(to: titleLabel, sizeTo: self, align: .topLeft, alignTo: .bottomLeft,  offset: .init(x:0,y:0), sizeOffset: .init(width:0, height:-24-32))
      }
   }
   func createAuthorLabel() -> NSLabel {
      return with(.init()) {
         $0.text = "Eonist"
         $0.textColor = .gray
         $0.centerVertically()
         $0.textAlignment = .right
         
         self.addSubview($0)
         $0.anchorAndSize(to: self, height: 24, align: .topRight, alignTo: .topRight,  offset: .init(x:-12,y:0))
      }
   }
   func createDateLabel() -> NSLabel {
      return with(.init()) {
         $0.text = "4H"
         $0.centerVertically()
         $0.textAlignment = .right
         $0.textColor = .gray
         self.addSubview($0)
         $0.anchorAndSize(to: authorLabel, sizeTo: self, height:32, align: .topRight, alignTo: .bottomRight,  offset: .init(x:0, y:2))
      }
   }
}

//      let textField = NSTextField()
//      textField.backgroundColor = NSColor.clear
//      textField.translatesAutoresizingMaskIntoConstraints = false
//      textField.isBordered = false

//      let textField = NSTextField()


//      aTextField = NSTextField(frame: frameRect)
//      aTextField?.drawsBackground = false
//      aTextField?.isBordered = false
//      self.addSubview(aTextField!)

