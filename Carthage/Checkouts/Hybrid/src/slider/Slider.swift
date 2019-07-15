import Foundation
/**
 * - Fixme: ⚠️️ Don't use autolayout inside the component (override layoutSubviews and set things with CGFloats etc)
 * - Fixme: ⚠️️ Add support for thumb.size based on background height
 */
open class Slider: View {
   public var onChange: OnChange = { _ in Swift.print("The user must assign this call-back") }
   lazy var button: Thumb = createThumb()
   lazy var background: Track = createBackground()
   let axis: Axis
   let buttonSide: CGFloat
   var tempThumbMousePos: CGPoint = .zero/*Needed for when you use the thumb to slide*/
   open var progress: CGFloat {
      didSet {
         let value: CGFloat = SliderHelper.thumbPosition(progress: progress, side: frame.size[axis], thumbSide: button.frame.size[axis])
         var pos: CGPoint = .zero
         pos[axis] = value
         button.update(offset: pos, align: .topLeft, alignTo: .topLeft)
      }
   }
   /**
    * Initiate
    */
   public init(axis: Axis, buttonSide: CGFloat, progress: CGFloat = 0) {
      self.axis = axis
      self.buttonSide = buttonSide
      self.progress = progress
      super.init(frame: .zero)
      _ = background
      _ = button
   }
   /**
    * Boilerplate
    */
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
