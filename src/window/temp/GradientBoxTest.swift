import Cocoa

class GradientBoxTest:View {
    override func drawRect(dirtyRect: NSRect) {
        Swift.print("GradientBoxTest.drawRect()")
        createContent()
    }
    func createContent(){
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
        
        let angle = -135*㎭
        Swift.print("angle: " + "\(angle)")
        let polarPoint = cgRect.center.polarPoint(150, angle)
        let line = LineGraphic(cgRect.center,polarPoint)
        line.initialize()
        
        Swift.print("cgRect.topLeft: " + "\(cgRect.topLeft)")
        let temp = PointParser.directionalAxisDifference(cgRect.center, cgRect.topLeft, angle)
        Swift.print(temp)
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
