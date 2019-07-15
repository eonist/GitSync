import Foundation
#if os(iOS)
import With
import Spatial
#elseif os(macOS)
import With_mac
import Spatial_macOS
#endif

extension CheckBoxButton {
   /**
    * TextField
    */
   func createTextField() -> Label {
      return with(.init()) {
         $0.text = self.text
         $0.textColor = CheckBoxButton.defaultStyle.textColor
         $0.textAlignment = .left
         $0.font = CheckBoxButton.defaultStyle.font
         $0.centerVertically()
         self.addSubview($0)
         $0.size(to: self, axis: .ver, toAxis: .ver)
         $0.anchor(to: self)
         $0.anchor(to: self.checkBox, align: .topRight, alignTo: .topLeft)
      }
   }
   /**
    * CheckBox
    */
   func createCheckBox() -> CheckButton {
      return with(.init(selected: self.selected, styles: self.checkBoxStyles, frame: .zero)) {//ToggleButton.init(isChecked:self.isChecked,texts:texts)
         self.addSubview($0)
         $0.anchor(to: self, align: .topRight, alignTo: .topRight)
         $0.size(to: self, axis: .ver, toAxis: .ver)
         $0.size(to: $0, axis: .hor, toAxis: .ver)
      }
   }
}
