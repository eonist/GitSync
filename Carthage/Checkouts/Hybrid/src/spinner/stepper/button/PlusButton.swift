import Foundation

public class PlusButton: Button {
   /**
    * Draw 2 lines that cross each other
    * - Note: we draw graphics here because it's the only pace where .frame is available when using auto layout
    */
   override public func drawLayout() {
      super.drawLayout()
      let r: CGFloat = self.frame.size.width
      let line1: CAShapeLayer = {
         let p1: CGPoint = .init(x: r / 4, y: r / 2)
         let p2: CGPoint = .init(x: r - (r / 4), y: (r / 2))
         let line = CGShapeUtil.drawLine(lineLayer: .init(), line: (p1, p2), lineStyle: (style.borderColor, 1))
         return line
      }()
      self.caLayer?.addSublayer(line1)
      let line2: CAShapeLayer = {
         let p1: CGPoint = .init(x: (r / 2), y: r / 4)
         let p2: CGPoint = .init(x: r / 2, y: r - (r / 4))
         let line = CGShapeUtil.drawLine(lineLayer: .init(), line: (p1, p2), lineStyle: (style.borderColor, 1))
         return line
      }()
      self.caLayer?.addSublayer(line2)
   }
}
