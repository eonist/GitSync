import Cocoa
import Hybrid_macOS
import Spatial_macOS
import With_mac

extension ConfirmationContainer {
   /**
    * Create button
    */
   func createOkButton() -> TextButton {
      return with(.init()) {
         addSubview($0)
         $0.textLabel.text = "OK"
         $0.anchorAndSize(to: self, align: .topLeft, alignTo: .topLeft, multiplier: .init(width: 0.5, height: 1), offset: .init(x:0,y:0), sizeOffset: .init(width:-12, height:0) )
         addSubview($0)
      }
   }
   /**
    * Create button
    */
   func createCancelButton() -> TextButton {
      return with(.init()) {
         addSubview($0)
         $0.textLabel.text = "Cancel"
         $0.anchorAndSize(to: self, align: .topRight, alignTo: .topRight, multiplier: .init(width: 0.5, height: 1), offset: .init(x:0,y:0), sizeOffset: .init(width:-12, height:0) )
         addSubview($0)
      }
   }
}
