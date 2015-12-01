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
        var rectGraphic = RectGraphic(200,100,NSColor.lightGrayColor())
        rectGraphic.setPosition(CGPoint(100,100))
        rectGraphic.initialize()
        
        let rect:CGRect = CGRect(rectGraphic.getPosition().x,rectGraphic.getPosition().y,rectGraphic.width,rectGraphic.height)
        Swift.print(rect.corners.count)
        
        for corner:CGPoint in rect.corners{
            //Swift.print(corner)
            var circle = CircleGraphic(10)
            circle.setPosition(corner)
            circle.initialize()
        }
        
        var centerCircle = CircleGraphic(10,NSColor.blueColor())
        centerCircle.setPosition(rect.center)
        centerCircle.initialize()
        
        let angle = -120*㎭
        Swift.print("angle: " + "\(angle)")
        let polarPoint = rect.center.polarPoint(150, angle)
        let line = LineGraphic(rect.center,polarPoint)
        line.initialize()
       
        let points = GradientBoxUtils.points(rect, angle)
        
        var startCircle = CircleGraphic(5,NSColor.greenColor())
        startCircle.setPosition(points.start)
        startCircle.initialize()
        
        var endCircle = CircleGraphic(5,NSColor.redColor())
        endCircle.setPosition(points.end)
        endCircle.initialize()
    }
}

