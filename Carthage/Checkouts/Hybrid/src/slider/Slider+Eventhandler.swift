import Foundation
/**
 * Eventhandler
 */
extension Slider {
   open func onButtonDown(p: CGPoint) {
      tempThumbMousePos = p
   }
   open func onButtonMove(p: CGPoint) {
      Swift.print("onButtonMove\(p)")
      self.progress = SliderHelper.progress(mouseVal: p[axis], tempMouseVal: tempThumbMousePos[axis], side: self.frame.size[axis], thumbSide: button.frame.size[axis])
      onChange(self.progress)
   }
   open func onBackgroundDown(p: CGPoint) {
      /*Not needed, as move fires immediatly*/
      onButtonMove(p: p)//relay, only needed for mac really ⚠️️
   }
   open func onBackgroundMove(p: CGPoint) {
      let progress = SliderHelper.progress(mouseVal: p[axis], tempMouseVal: button.frame.size[axis] / 2, side: frame.size[axis], thumbSide: button.frame.size[axis])
      self.progress = progress
      onChange(self.progress)
   }
}
