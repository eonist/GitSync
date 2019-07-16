import Cocoa
import Spatial_macOS
import With_mac
import Hybrid_macOS
/**
 * Create
 */
extension OptionCell {
   /**
    * Create Title Label
    */
   @objc func createDescriptionLabel() -> NSLabel {
      return with(.init()) {
         $0.text = "title"
         $0.textColor = .black//.black
         $0.backgroundColor = .yellow
         $0.font = .systemFont(ofSize: 14) //.boldSystemFont(ofSize: 20.0)
         $0.textAlignment = .left
         $0.centerVertically()
         self.textField = $0 // Fixme: rather remove self.textField and don't add
         self.addSubview($0)
         $0.anchorAndSize(to: self, offset: .init(x: 12, y: 0))
      }
   }
   /**
    * Create CheckBox
    */
   func createCheckBox() -> CheckButton {
      return with(.init(selected: false, styles: CheckButton.defaultStyles)) {
         //$0.anchorAndSize(to: self, width: 42, align: .topRight, alignTo: .topRight, offset: .init(x: -12, y: 0))
         self.addSubview($0)
         $0.anchorAndSize(to: self, width: 24, height: 24, align: .centerRight, alignTo: .centerRight,offset: .init(x: -12, y: 0))
      }
   }
}
