import Cocoa
@testable import Utils
@testable import Element


extension GraphScrollerHandler3{
    /**
     * This is set from movergroup
     */
    func setProgressValue(_ progress: CGFloat, _ dir: Dir) {//onScroll -> tick -> update y value of graph points
        //        Swift.print("setProgress")
        guard dir == .hor else {return}//forces hor as major direction only
        contentContainer.layer?.position = CGPoint(progress,0)//moves the contentContainer (locks it into hor movement)
        frameTick()
        (progressable as! GraphScrollView3).setProgressVal(progress,dir)
    }
    func frameTick() {
//        Swift.print("frameTick")
        let x = moverGroup.result.x
        let absX = abs(x)
        if absX >= prevX + 100 {/*only redraw at every 100px threshold*/
            tick(x)
            prevX = absX
        }else if absX < prevX{
            tick(x)
            prevX = absX - 100
        }
    }
    /**
     *
     */
    func updateGraphLine(){
        let pointsWithin:[CGPoint] = pool.map{points[$0.idx]}//Utils.calcPointsWithin(x: x, width: width, points: points)//
        //update line
        let graphLine = graphArea.graphLine
        graphLine.line!.cgPath = CGPathParser.polyLine(pointsWithin)//cgPath.clone()//applies the new path
        graphLine.line!.draw()//draws the path
    }
    /**
     * This method is only called on every 100th px threshold
     */
    private func tick(_ x:CGFloat){
        //Swift.print("Tick: \(x)")
        Swift.print("🍌 Tick")
        
        //find range of visible points
//        let pointsWithin:[CGPoint] = Utils.calcPointsWithin(x: x, width: width, points: points)//pool.map{points[$0.idx]}
        //update line
//        let graphLine = graphArea.graphLine
//        graphLine.line!.cgPath = CGPathParser.polyLine(pointsWithin)//cgPath.clone()//applies the new path
//        graphLine.line!.draw()//draws the path
        
//        pool.forEach{
//            Swift.print("$0.idx: " + "\($0.idx)")
//        }
        //Bouncy anim
        let minY = self.minY()//Utils.minY(x: x, width: width, points:points)
        Swift.print("⚠️️ minY: " + "\(minY))")
        if let prevMinY = self.prevMinY, prevMinY != minY {/*Skips anim if the graph doesn't need to scale*/
            self.initAnim()/*Initiates the animation*/
            Swift.print("🍏 animate")
        }else{
            //updateGraphLine()
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
//        static func calcMinY(x:CGFloat, width:CGFloat, points:[CGPoint]) -> CGFloat{
//            let x1:CGFloat = -1 * x/*Here we flip the x to be positive*/
//            let x2:CGFloat = (-1 * x) + width
//            /**/
//            let minX:CGFloat = x1/*The begining of the current visible graph*/
//            let maxX:CGFloat = x2/*The end of the visible range*/
//            let minY:CGFloat = Utils.minY(minX:minX,maxX:maxX,points:points)/*Returns the smallest Y value in the visible range*/
//            return minY
//        }
        static func calcPointsWithin(x:CGFloat, width:CGFloat, points:[CGPoint],padding:CGFloat = 200) -> [CGPoint]{
            let minMax = Utils.minMax(x: x, width: width,padding:padding)
            return pointsWithin(minX: minMax.min, maxX: minMax.max, points: points)
        }
        /**
         * New
         * PARAM: padding: so that the points don't go out of view, when scrolling
         */
        static func minMax(x:CGFloat, width:CGFloat, padding:CGFloat = 200) -> (min:CGFloat,max:CGFloat){
            let x1:CGFloat = -1 * x/*Here we flip the x to be positive*/
            let x2:CGFloat = (-1 * x) + width
            //for some strange reason you need 200px padding. But you should only need 100px
//            let padding:CGFloat = padding//
            let minX:CGFloat = x1 - padding/*The begining of the current visible graph*/
            let maxX:CGFloat = x2 + padding/*The end of the visible range*/
            return (minX,maxX)
        }
        /**
         * Returns minY for the visible section of the graph
         * NOTE: The visible graph is the portion of the graph that is visible at any given progression.
         * PARAM: minX: The begining of the current visible graph
         * PARAM: maxX: The end of the visible range
         */
        static func minY(x:CGFloat,width:CGFloat,points:[CGPoint],padding:CGFloat = 200) -> CGFloat {
//          let yValuesWithinMinXAndMaxX:[CGFloat] = points.filter{$0.x >= minX && $0.x <= maxX}.map{$0.y}/*We gather the points within the current minX and maxX*/
            return calcPointsWithin(x: x, width: width, points: points, padding:padding).map{$0.y}.min()!
        }
        /**
         * New
         */
        static func pointsWithin(minX:CGFloat,maxX:CGFloat,points:[CGPoint]) -> [CGPoint]{
            return points.filter{$0.x >= minX && $0.x <= maxX}.map{$0}/*We gather the points within the current minX and maxX*/
        }
        /**
         * New
         */
        static func calcRatio(/* x:CGFloat, */minY:CGFloat, height:CGFloat) -> CGFloat{
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
    func minY () -> CGFloat{
        return pool.map{points[$0.idx].y}.min()!
    }
    /**
     * Initiates the animation sequence
     * NOTE: this method can be called in quick sucession as it stops any ongoing animation before it is started
     */
    func initAnim(){
        Swift.print("initAnim")
        let minY = self.minY()//Utils.minY(x:x, width:width, points:points)
//        let x:CGFloat = moverGroup.result.x
        let ratio:CGFloat = Utils.calcRatio(/*x: x, */minY: minY, height: height)
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
//        let x = moverGroup.result.x
        let pts:[CGPoint] = pool.map{points[$0.idx]}//Utils.calcPointsWithin(x: x, width: width, points: points)
        let scaledPts:[CGPoint] = Utils.calcScaledPoints(points: pts, ratio: val, height: height)
        /*GraphPoints*/
        
        graphArea.graphLine.line!.cgPath = CGPathParser.polyLine(scaledPts)
        graphArea.graphLine.line!.draw() /*draws the path*///TODO: ⚠️️ it draws the entire path I think, we really only need the portion that is visible
        
        for (i,obj) in pool.enumerated(){
            let graphDot = (obj.item as! GraphScrollerItem).graphDot
            let pt = scaledPts[i]
            graphDot!.layer?.position = CGPoint(0,pt.y)
        }
    }
}

