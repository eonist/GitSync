import Cocoa
import Spatial_macOS
import With_mac
/**
 * CommitListView
 */
extension CommitListView {
   /**
    * Back
    */
   func onPrefsButtonClick() {
      Swift.print("onPrefsButtonClick")
      Nav.setView(viewType: .prefs(.prefsList))
   }
}
