import Cocoa
@testable import Utils
@testable import Element
//Enough for tonight 🏀
    //almost there, just fix the setProgressFlow, see CommitList and TreeList, ✅
    //Try the demo list in appdelegate with sidescrolling fastlist. see if it works! ✅
    //drop the ppoints for now and just focus on colors ✅
    //when you have it, try adding the bouncy anim
    //clean up things
    //then trottle the fastList to FPS
    //

class GraphScrollerHandler3:ElasticScrollerFastListHandler,GraphScrollerDecorator3{
    override func onScrollWheelChange(_ event:NSEvent){/*Direct scroll*/
        guard dir == .hor else {return}
        moverGroup.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup.updatePosition(true)/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p:CGPoint = moverGroup.result
        setProgressVal(p.x,.hor)
        frameTick()
    }
    /**
     * this is set from movergroup,
     */
    func setProgressValue(_ progress: CGFloat, _ dir: Dir) {//onScroll -> tick -> update y value of graph points
//        Swift.print("setProgress")
        guard dir == .hor else {return}//forces hor as major direction only
        contentContainer.layer?.position = CGPoint(progress,0)//moves the contentContainer (locks it into hor movement)
        frameTick()
        (progressable as! GraphScrollView3).setProgressVal(progress,dir)
    }
    private func frameTick() {
        let x = moverGroup.result.x
        
        let absX = abs(x)
//        Swift.print("absX: " + "\(absX)" + " prevX: " + "\(prevX)")
        
        if absX >= prevX + 100 {/*only redraw at every 100px threshold*/
            //Swift.print("if x:\(x)")
            tick(x)
            prevX = absX
        }else if absX < prevX{
            //Swift.print("else if x: \(x)")
            tick(x)
            prevX = absX - 100
        }
    }
    /**
     * This method is only called on every 100th px threshold
     */
    private func tick(_ x:CGFloat){
        //Swift.print("Tick: \(x)")
        Swift.print("🍌 Tick")
        
        //find range of visible points
        let pointsWithin:[CGPoint] = Utils.calcPointsWithin(x: x, width: width, points: points)
        
        let graphLine = graphArea.graphLine
        graphLine.line!.cgPath = CGPathParser.polyLine(pointsWithin)//cgPath.clone()//applies the new path
        graphLine.line!.draw()//draws the path
        //Bouncy anim
        let minY = Utils.calcMinY(x: x, width: width, points:points)
        Swift.print("⚠️️ minY: " + "\(minY))")
        if let prevMinY = self.prevMinY, prevMinY != minY {/*Skips anim if the graph doesn't need to scale*/
            self.initAnim()/*Initiates the animation*/
            Swift.print("🍏 animate")
        }
        self.prevMinY = minY//set the prev anim
    }
}
extension GraphScrollerHandler3{
    /**
     * utilities related
     */
    class Utils{
        /**
         * New
         * PARAM: width: the maskSize.width
         */
        static func calcMinY(x:CGFloat, width:CGFloat, points:[CGPoint]) -> CGFloat{
            let x1:CGFloat = -1 * x/*Here we flip the x to be positive*/
            let x2:CGFloat = (-1 * x) + width
            /**/
            let minX:CGFloat = x1/*The begining of the current visible graph*/
            let maxX:CGFloat = x2/*The end of the visible range*/
            let minY:CGFloat = Utils.minY(minX:minX,maxX:maxX,points:points)/*Returns the smallest Y value in the visible range*/
            return minY
        }
        //
        static func calcPointsWithin(x:CGFloat, width:CGFloat, points:[CGPoint]) -> [CGPoint]{
            let x1:CGFloat = -1 * x/*Here we flip the x to be positive*/
            let x2:CGFloat = (-1 * x) + width
            /**/
            //for some strange reason you need 200px padding. But you should only need 100px
            let padding:CGFloat = 200//so that the points don't go out of view, when scrolling
            let minX:CGFloat = x1 - padding/*The begining of the current visible graph*/
            let maxX:CGFloat = x2 + padding/*The end of the visible range*/
            return pointsWithin(minX: minX, maxX: maxX, points: points)
        }
        /**
         * Returns minY for the visible graph
         * NOTE: The visible graph is the portion of the graph that is visible at any given progression.
         * PARAM: minX: The begining of the current visible graph
         * PARAM: maxX: The end of the visible range
         */
        static func minY(minX:CGFloat,maxX:CGFloat,points:[CGPoint]) -> CGFloat {
            //        let yValuesWithinMinXAndMaxX:[CGFloat] = points.filter{$0.x >= minX && $0.x <= maxX}.map{$0.y}/*We gather the points within the current minX and maxX*/
            return pointsWithin(minX: minX, maxX: maxX, points: points).map{$0.y}.min()!
        }
        /**
         * New
         */
        private static func pointsWithin(minX:CGFloat,maxX:CGFloat,points:[CGPoint]) -> [CGPoint]{
            return points.filter{$0.x >= minX && $0.x <= maxX}.map{$0}/*We gather the points within the current minX and maxX*/
        }
        
        /**
         * New
         */
        static func calcRatio( x:CGFloat, minY:CGFloat, height:CGFloat) -> CGFloat{
            //let dist:CGFloat = 400.cgFloat.distance(to: minY)
            let diff:CGFloat = height + (-1 * minY)/*Since graphs start from the bottom we need to flip the y coordinates*/
            let ratio:CGFloat = height / diff/*Now that we have the flipped y coordinate we can get the ratio to scale all other points with */
            return ratio
        }
        /**
         * New
         */
        static func calcScaledPoints(points:[CGPoint], ratio:CGFloat, height:CGFloat) -> [CGPoint]{
            let scaledPoints = points.map{CGPointModifier.scale($0/*<--point to scale*/, CGPoint($0.x,height)/*<--pivot*/, CGPoint(1,ratio)/*<--Scalar ratio*/)}
            return scaledPoints
        }
    }

}
/**
 * Animation related
 */
extension GraphScrollerHandler3 {
    /**
     * Initiates the animation sequence
     * NOTE: this method can be called in quick sucession as it stops any ongoing animation before it is started
     */
    func initAnim(){
        Swift.print("initAnim")
        let x = moverGroup.result.x
        let minY = Utils.calcMinY(x:x, width:width, points:points)
        let ratio = Utils.calcRatio(x: x, minY: minY, height: height)
        Swift.print("ratio: " + "\(ratio)")
        /*Setup interuptable animator*/
        if animator == nil {//upgrade to latest anim lib ⚠️️
            let initValues:NumberSpringer.InitValues = (value:1,targetValue:ratio,velocity:0,stopVelocity:0)
            animator = NumberSpringer(interpolateValue, initValues,NumberSpringer.initConfig)/*Anim*/
        }
        animator?.targetValue = ratio
        if animator!.stopped {animator!.start()}
    }
    /**
     * Interpolates between 0 and 1 while the duration of the animation
     * NOTE: ReCalc the hValue indicators (each graph range has a different max hValue etc)
     */
    private func interpolateValue(_ val:CGFloat){
        var positions:[CGPoint] = []
        positions = Utils.calcScaledPoints(points: points, ratio: val, height: height)
        /*GraphPoints*/
        graphArea.graphLine.line!.cgPath = CGPathParser.polyLine(positions)
        graphArea.graphLine.line!.draw() /*draws the path*///TODO: ⚠️️ it draws the entire path I think, we really only need the portion that is visible
        for (i,obj) in graphArea.graphDots.enumerated() {
            obj.layer?.position = positions[i]//positions the graphDots
        }
    }
}
