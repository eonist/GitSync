import Cocoa

class GradientBoxTest:View {
    override func drawRect(dirtyRect: NSRect) {
        //Swift.print("GradientBoxTest.drawRect()")
        drawContent()
    }
    func drawContent(){
        let rect = RectGraphic(200,100,NSColor.lightGrayColor())
        rect.setPosition(CGPoint(100,100))
        rect.initialize()
        
        let cgRect:CGRect = CGRect(rect.getPosition().x,rect.getPosition().y,rect.width,rect.height)
        Swift.print(cgRect.corners.count)
        
        for corner:CGPoint in cgRect.corners{
            //Swift.print(corner)
            let circle = CircleGraphic(10)
            circle.setPosition(corner)
            circle.initialize()
        }
        
        let centerCircle = CircleGraphic(10,NSColor.blueColor())
        centerCircle.setPosition(cgRect.center)
        centerCircle.initialize()
        
        let angle = -10*㎭
        Swift.print("angle: " + "\(angle)")
        let polarPoint = cgRect.center.polarPoint(150, angle)
        let line = LineGraphic(cgRect.center,polarPoint)
        line.initialize()
        
        
        //continue here: it finally works, add the other quadrants and your good!
        

        let q1:(CGFloat,CGFloat) = (-180*㎭,-90*㎭)
        
        
        let q2:(CGFloat,CGFloat) = (-90*㎭,0)
        //q2 = angle from TR to BR
        //q3 = angle from BR to BL
        //q4 = angle from BL to TL
        //within q1
        
        //within q2
        
        //within q3
        
        //within q4
        var cornerPoint:CGPoint = CGPoint()
        switch true{
            case CGFloatRangeAsserter.within(q1, angle):
                Swift.print("Q1")
                cornerPoint = cgRect.topLeft
            case CGFloatRangeAsserter.within(q2, angle):
                Swift.print("Q2")
                cornerPoint = cgRect.topRight
            case CGFloatRangeAsserter.contained(Trig.b, angle):
                Swift.print("bottom")
            case CGFloatRangeAsserter.contained(Trig.l, angle):
                Swift.print("left")
            default:
                Swift.print("Deal with exact angles here")
                break;
        }
        
        
        let distPoint = PointParser.directionalAxisDistance(cgRect.center, cornerPoint, angle)
        Swift.print("distPoint: " + String(distPoint))
        let p:CGPoint = cgRect.center.polarPoint(distPoint.x, angle)
        
        Swift.print("P: " + String(p))
        
        let pCircle = CircleGraphic(5,NSColor.redColor())
        pCircle.setPosition(p)
        pCircle.initialize()

        
        //create Line and Circle And Rect for easy testing, and document it wells, and it must be simple to add styles to them
        
        //create a visual feedback test with a line, corners as circles etc
        //test different rotations
        //for p1:
        //rotate all corners from the center to the negative rotation value
        //Measure which point has the lowest y value.
        //measure the distance between this y value and the center y value
        //use this distance to find the p1 and p2
    }
}
