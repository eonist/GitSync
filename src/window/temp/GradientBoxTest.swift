import Cocoa

class GradientBoxTest:View {
    override func drawRect(dirtyRect: NSRect) {
        //Swift.print("GradientBoxTest.drawRect()")
        drawContent()
    }
    func drawContent(){
        let rect = RectGraphic(200,100)
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
        
        let angle = -100*㎭
        Swift.print("angle: " + "\(angle)")
        let polarPoint = cgRect.center.polarPoint(150, angle)
        let line = LineGraphic(cgRect.center,polarPoint)
        line.initialize()
        
        Swift.print("cgRect.topLeft: " + "\(cgRect.topLeft)")
        let temp = PointParser.directionalAxisDistance(cgRect.center, cgRect.topLeft, angle)
        Swift.print(temp)
        
        
        let q1A = Trig.angle(cgRect.center, cgRect.topLeft)
        let q1B = Trig.angle(cgRect.center, cgRect.top)
        let q1 = (q1A,q1B)
        
        let q2A = Trig.angle(cgRect.center, cgRect.topLeft)
        let q2B = Trig.angle(cgRect.center, cgRect.top)
        let q2 = (q2A,q2B)
        //q2 = angle from TR to BR
        //q3 = angle from BR to BL
        //q4 = angle from BL to TL
        //within q1
        
        //within q2
        
        //within q3
        
        //within q4
        var p:CGPoint!
        switch true{
            case CGFloatRangeAsserter.contained(q1, angle):
                Swift.print("Q1")
                let slope = PointParser.slope(cgRect.center, polarPoint)
                let x = PointParser.x(cgRect.center, cgRect.top.y, slope)
                p = CGPoint(x,cgRect.top.y)
                Swift.print("P: " + String(p))
            case CGFloatRangeAsserter.contained(q2, angle):
                Swift.print("Q2")
            case CGFloatRangeAsserter.contained(Trig.b, angle):
                Swift.print("bottom")
            case CGFloatRangeAsserter.contained(Trig.l, angle):
                Swift.print("left")
            default:
                Swift.print("Deal with exact angles here")
                break;
        }
        
        let pCircle = CircleGraphic(10,NSColor.whiteColor())
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
