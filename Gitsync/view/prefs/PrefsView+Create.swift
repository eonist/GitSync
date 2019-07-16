import Cocoa
import With_mac
import Hybrid_macOS
import Spatial_macOS
/**
 * Create
 */
extension PrefsView {
   /**
    * BackButton
    */
   func createBackButton() -> TextButton {//(style: TextButton.defaultStyle, frame: .zero))
      return with(.init(text: "Back", style: TextButton.defaultTextButtonStyle, frame: .zero)) {
         $0.textLabel.font = .systemFont(ofSize: 14)
         $0.textLabel.centerVertically()
         addSubview($0)
         $0.anchorAndSize(to: self, width: 72, height: 24, align: .topLeft, alignTo: .topLeft, offset: .init(x: 12, y: 6))
         $0.upInsideCallBack = onBackButtonClick
      }
   }
   /**
    * PrefsList
    */
   func createPrefsList() -> PrefsList {
      return with(.init(frame: .zero)) {
         addSubview($0)
         //pin to backButton and bottom of view
         $0.anchorAndSize(to: self, align: .topLeft, alignTo: .topLeft, offset: .init(x: 0, y: 6 + 24 + 6), sizeOffset: .init(width: 0, height: 6 + 24 + 6) )
      }
   }
}

 //MacOS has strange default compression priorities: https://stackoverflow.com/questions/39013002/why-adding-constraints-removes-the-ability-to-resize-nswindow
 //      list.setContentCompressionResistancePriority(NSLayoutConstraint.Priority(rawValue: 249), for: NSLayoutConstraint.Orientation.horizontal)
 //      list.setContentCompressionResistancePriority(NSLayoutConstraint.Priority(rawValue: 249), for: NSLayoutConstraint.Orientation.vertical)
