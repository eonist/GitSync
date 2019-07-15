import Foundation
#if os(iOS)
import With
import Spatial
#elseif os(macOS)
import With_mac
import Spatial_macOS
#endif

/**
 * Create
 */
extension TextButton {
   /**
    * Create text label
    */
   open func createTextLabel() -> Label {
      return with(.init()) {
         addSubview($0)
         $0.text = self.text
         $0.textColor = .orange
//         Swift.print("$0.textColor:  \($0.textColor)")
         $0.textAlignment = .center
         $0.font = .systemFont(ofSize: 20)
         $0.centerVertically()
         $0.anchorAndSize(to: self )
         #if os(macOS)//if applied in iOS the text becomes gray
         $0.isEnabled = false/*Disables interactivity, so that upInside callback works in macOS*/
         #endif
      }
   }
}
