import Foundation
#if os(iOS)
import With
import Spatial
#elseif os(macOS)
import With_mac
import Spatial_macOS
#endif

extension Spinner {
   /**
    * Create text label
    */
   open func createTextLabel() -> Label {
      let text: String = self.text + "\(stepper.initData.value)"
      return with(.init()) {
         self.addSubview($0)
         $0.text = text
         $0.textColor = CheckBoxButton.defaultStyle.textColor//⚠️️ fix
         $0.textAlignment = .left
         $0.font = CheckBoxButton.defaultStyle.font//⚠️️ fix
         $0.centerVertically()
         $0.anchor(to: self)
         $0.anchor(to: stepper, align: .topRight, alignTo: .topLeft)
         $0.size(to: self, axis: .ver, toAxis: .ver)
      }
   }
   /**
    * Stepper
    */
   func createStepper() -> Stepper {
      return with(.init(initData: self.initData)) {
         self.addSubview($0)
         $0.anchor(to: self, align: .topRight, alignTo: .topRight )
         $0.size(to: self, axis: .hor, toAxis: .ver, offset: 12, multiplier: 2)
         $0.size(to: self, axis: .ver, toAxis: .ver)
         $0.onChange = {value in
            let text: String = self.text + "\(self.stepper.initData.value)"
            self.textLabel.text = text//setTitle(, for: .normal)
            self.onChange(value)
         }//relay callback
      }
   }
}
