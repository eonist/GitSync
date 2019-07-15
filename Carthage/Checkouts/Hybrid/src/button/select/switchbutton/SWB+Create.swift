import Foundation
#if os(iOS)
import With
import Spatial
#elseif os(macOS)
import With_mac
import Spatial_macOS
#endif

extension SwitchButton {
   /**
    * TextField
    */
   func createTextField() -> Label {
      return with(.init()) {
         $0.text = self.text
         $0.textColor = SwitchButton.defaultStyle.textColor
         $0.textAlignment = .left
         $0.font = SwitchButton.defaultStyle.font
         $0.centerVertically()
         self.addSubview($0)
         $0.size(to: self, axis: .ver, toAxis: .ver)
         $0.anchor(to: self)
         $0.anchor(to: self.switchBox, align: .topRight, alignTo: .topLeft)
      }
   }
   /**
    * CheckBox
    */
   func createSwitch() -> Switch {
      return with(.init(isSelected: self.selected)) {
         self.addSubview($0)
         $0.anchor(to: self, align: .topRight, alignTo: .topRight)
         $0.size(to: self, axis: .ver, toAxis: .ver)
         $0.size(to: self, axis: .hor, toAxis: .ver, multiplier: 2)
      }
   }
}
