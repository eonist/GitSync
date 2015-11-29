import Cocoa
/**
 * Testing class for the GradientBox, which is now working 100%
 */
class GradientBoxTest:View {
    override func drawRect(dirtyRect: NSRect) {
        //Swift.print("GradientBoxTest.drawRect()")
        drawContent()
    }
    func drawContent(){
        let rectGraphic = RectGraphic(200,100,NSColor.lightGrayColor())
        rectGraphic.setPosition(CGPoint(100,100))
        rectGraphic.initialize()
        
        let rect:CGRect = CGRect(rectGraphic.getPosition().x,rectGraphic.getPosition().y,rectGraphic.width,rectGraphic.height)
        Swift.print(rect.corners.count)
        
        for corner:CGPoint in rect.corners{
            //Swift.print(corner)
            let circle = CircleGraphic(10)
            circle.setPosition(corner)
            circle.initialize()
        }
        
        let centerCircle = CircleGraphic(10,NSColor.blueColor())
        centerCircle.setPosition(rect.center)
        centerCircle.initialize()
        
        let angle = -120*㎭
        Swift.print("angle: " + "\(angle)")
        let polarPoint = rect.center.polarPoint(150, angle)
        let line = LineGraphic(rect.center,polarPoint)
        line.initialize()
       
        let points = GradientBoxUtils.points(rect, angle)
        
        let startCircle = CircleGraphic(5,NSColor.greenColor())
        startCircle.setPosition(points.start)
        startCircle.initialize()
        
        let endCircle = CircleGraphic(5,NSColor.redColor())
        endCircle.setPosition(points.end)
        endCircle.initialize()
    }
}

class GradientBoxUtils{
    /**
     *
     */
    class func points(rect:CGRect,_ angle:CGFloat)->(start:CGPoint,end:CGPoint){
        var cornerPoint:CGPoint = CGPoint()
        switch true{
        case CGFloatRangeAsserter.within(Trig.tl, angle):
            //Swift.print("Q1")
            cornerPoint = rect.topLeft
        case CGFloatRangeAsserter.within(Trig.tr, angle):
            //Swift.print("Q2")
            cornerPoint = rect.topRight
        case CGFloatRangeAsserter.within(Trig.br, angle):
            //Swift.print("Q3")
            cornerPoint = rect.bottomRight
        case CGFloatRangeAsserter.within(Trig.bl, angle):
            //Swift.print("Q4")
            cornerPoint = rect.bottomLeft
        default:
            fatalError("Angle is out of the allowed range (-π to π): " + "\(angle)")
            break;
        }
        let distPoint = PointParser.directionalAxisDistance(rect.center, cornerPoint, angle)
        //Swift.print("distPoint: " + String(distPoint))
        let end:CGPoint = rect.center.polarPoint(distPoint.x, angle)
        //Swift.print("end: " + String(end))
        let start:CGPoint = rect.center.polarPoint(-distPoint.x, angle)
        //Swift.print("start: " + String(start))
        return (start,end)
    }
}