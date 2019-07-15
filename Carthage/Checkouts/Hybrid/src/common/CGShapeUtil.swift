import Foundation
import CoreGraphics
import QuartzCore

internal class CGShapeUtil {
   typealias Corners = (topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat)
   typealias Style = (fill: Color, stroke: Color, strokeWidth: CGFloat)
   typealias LineStyle = (stroke: Color, strokeWidth: CGFloat)
   /**
    * EXAMPLE: roundRect(5,100,100)
    * - Fixme: ⚠️️ Draws a rounded rectangle using the size of individual x and y radii to draw the rounded corners.: drawRoundRectComplex2(x:Number, y:Number, width:Number, height:Number, radiusX:Number, radiusY:Number, topLeftRadiusX:Number, topLeftRadiusY:Number, topRightRadiusX:Number, topRightRadiusY:Number, bottomLeftRadiusX:Number, bottomLeftRadiusY:Number, bottomRightRadiusX:Number, bottomRightRadiusY:Number):void you have the code for this somewhere
    * - NOTE: was: //radius:CGFloat = 10, _ w:CGFloat = 100,_ h:CGFloat = 100, _ x:CGFloat = 0,_ y:CGFloat = 0
    * - NOTE: you can also use: CGPathCreateWithRoundedRect() and CGPathAddRoundedRect()
    * - Fixme: ⚠️️ use apples native roundedCorner class to represents the corner fillets, and pas cgrect, also add shouldclose flag
    */
   static func roundedRect(rect: CGRect, radius: Corners) -> CGMutablePath {
      let path: CGMutablePath = .init()
      path.move(to: .init(x:rect.midX, y:rect.minY))//swift 3 was-> CGPathMoveToPoint
      path.addArc(tangent1End: .init(x:rect.maxX, y:rect.minY), tangent2End: .init(x:rect.maxX, y:rect.maxY), radius: radius.topRight)//TR //swift 3 was CGPathAddArcToPoint
      path.addArc(tangent1End: .init(x:rect.maxX, y:rect.maxY), tangent2End: .init(x:rect.minX, y:rect.maxY), radius: radius.bottomRight)
      path.addArc(tangent1End: .init(x:rect.minX, y:rect.maxY), tangent2End: .init(x:rect.minX, y:rect.minY), radius: radius.bottomLeft)
      path.addArc(tangent1End: .init(x:rect.minX, y:rect.minY), tangent2End: .init(x:rect.maxX, y:rect.minY), radius: radius.topLeft)
      path.closeSubpath()
      return path
   }
   /**
    * Draws rounded rect
    */
   static func drawRoundedRect(layer: CAShapeLayer, rect: CGRect, radius: Corners, style: Style) -> CAShapeLayer {
      let path = roundedRect(rect: rect, radius: radius)
      layer.path = path/*Setup the CAShapeLayer with the path, colors, and line width*/
      layer.fillColor = style.fill.cgColor
      layer.strokeColor = style.stroke.cgColor
      layer.lineWidth = style.strokeWidth
      layer.lineCap = .round
      return layer
   }
   /**
    * Draw line
    * NOTE: remember to: shapeLayer.addSublayer(lineLayer)
    * It's also possible to do this with UIBezierPath
    * ## Examples
    * let path:UIBezierPath = {
    *    let aPath = UIBezierPath.init()//cgPath: linePath
    *    aPath.move(to: p1)
    *    aPath.addLine(to: p2)
    *    aPath.close()//Keep using the method addLineToPoint until you get to the one where about to close the path
    *    return aPath
    * }()
    */
   static func drawLine(lineLayer: CAShapeLayer, line: (p1: CGPoint, p2: CGPoint), lineStyle: LineStyle) -> CAShapeLayer {
      let path: CGMutablePath = .init()
      path.move(to: line.p1)
      path.addLine(to: line.p2)
      lineLayer.path = path/*Setup the CAShapeLayer with the path, colors, and line width*/
      lineLayer.strokeColor = lineStyle.stroke.cgColor
      lineLayer.lineWidth = lineStyle.strokeWidth
      lineLayer.lineCap = .round
      return lineLayer
   }
   /**
    * Draws circle
    * - PARAM: progress: 0-1
    * ## Examples:
    * let circlePath:BezierPath = .init(ovalIn: rect)//(arcCenter: CGPoint(x: circle.center.x, y: circle.center.y), radius:circle.radius, startAngle: CGFloat(Double.pi * -0.5), endAngle: CGFloat(Double.pi * 1.5), clockwise: true)/*The path should be the entire circle, for the strokeEnd and strokeStart to work*/
    */
   static func drawCircle(with circleLayer: CAShapeLayer, circle: (center: CGPoint, radius: CGFloat), style: Style, progress: CGFloat) -> CAShapeLayer {
      let pt: CGPoint = .init(x: circle.center.x - circle.radius, y: circle.center.y - circle.radius)
      let size: CGSize = .init(width: circle.radius * 2, height: circle.radius * 2)
      let rect: CGRect = .init(origin: pt, size: size)
      return drawCircle(with: circleLayer, rect: rect, style: style, progress: progress)
   }
   /**
    * Draws circle
    * - PARAM: progress: 0-1
    */
   static func drawCircle(with circleLayer: CAShapeLayer, rect: CGRect, style: Style, progress: CGFloat) -> CAShapeLayer {
      circleLayer.path = .init(ellipseIn: rect, transform: nil)/*Setup the CAShapeLayer with the path, colors, and line width*/
      circleLayer.fillColor = style.fill.cgColor
      circleLayer.strokeColor = style.stroke.cgColor
      circleLayer.lineWidth = style.strokeWidth
      circleLayer.lineCap = .round
      circleLayer.strokeEnd = progress/*Sets progress of the stroke between predefined start and predefined end*/
      return circleLayer
   }
}
