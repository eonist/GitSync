import Foundation

extension Slider {
   /**
    * Sets the thumbs side and repositions the thumb accordingly
    */
   open func setThumbSide(width: CGFloat) {
      button.frame.size = .init(width:width, height:width)
      let value: CGFloat = SliderHelper.thumbPosition(progress: progress, side: frame.size[axis], thumbSide: button.frame.size[axis])
      var pos: CGPoint = .zero
      pos[axis] = value
      button.update(offset: pos, align: .topLeft, alignTo: .topLeft)
   }
}
