import Cocoa
@testable import Utils
@testable import Element
/**
 * TODO: ⚠️️ Draw a bit on paper to make sure you understand what needs to be coded ✅
 * TODO: ⚠️️ Draw more points ✅
 * TODO: ⚠️️ Implement ElasticView ✅
 * TODO: ⚠️️ Implement integer animate to onProgress ticks
    //you need to hock into the on progress ticks and log these 👈
    //you need to get the active range of dots
    //you need to get the vValuea for this dot
    //you need to get the max vValue in the range
    //you need to find the scale to go from prevMaxVal to newMAxVal
    //you need to scale all graphPoints to this new scale
    //you need to scale at every tick, use modulo and prevTick
    //you then need to animate the scale at every tick
    //
 */
class GraphAreaX:Element{
    var graphDots:[Element] = []//rename to graphDots for clearity?
    var graphLine:GraphLine?
    var contentContainer:Element? {return scrollView?.contentContainer}//contains dots and line
    var scrollView:GraphScrollView?
    var points:[CGPoint]?
    var prevPoints:[CGPoint]?/*interim var*/
    //var animator:Animator?/*Anim*/
    override func resolveSkin() {
        super.resolveSkin()
        createUI()
    }
    /**
     * Creates the UI Components
     */
    func createUI(){
        scrollView = addSubView(GraphScrollView(getWidth(),getHeight(),self))
        _ = contentContainer?.addSubView(Section(100*19,getHeight(),contentContainer,"bg"))
        //scrollView?.contentContainer = contentContainer!
        createGraphLine()
        createGraphPoints()
    }
    /**
     * Creates the Graph line
     */
    func createGraphLine(/*_ vValues:[CGFloat], _ maxValue:CGFloat*/){
        Swift.print("createGraphLine")
        let vValues:[CGFloat] = Array(repeating:0, count:GraphX.config.tCount)/*placeholder values*/
        let maxValue:CGFloat = 0
        points = GraphUtils.points(CGSize(w,h), CGPoint(0,0), CGSize(100,100), vValues, maxValue, 0, 0)
        let path:IPath = PolyLineGraphicUtils.path(points!)
        graphLine = contentContainer!.addSubView(GraphLine(getWidth(),getHeight(),path,contentContainer!))
    }
    /**
     * Creates The visual Graph points that hover above the Graph line
     * NOTE: We could create something called GraphPoint, but it would be another thing to manager so instead we just use an Element with id: graphPoint
     */
    func createGraphPoints(){
        points!.forEach{
            let graphPoint:Element = contentContainer!.addSubView(Element(NaN,NaN,contentContainer!,"graphPoint"))
            graphDots.append(graphPoint)
            graphPoint.setPosition($0)
        }
    }
    /**
     * Re-calc and set the graphPoint positions (for instance if the hValues has changed etc)
     */
    func updateGraph(_ vValues:[CGFloat]){
        Swift.print("updateGraph.vValues: " + "\(vValues)")
        //prevPoints = points.map{$0}//grabs the location of where the pts are now
        let maxValue:CGFloat = vValues.max()!//Finds the largest number in among vValues
        Swift.print("maxValue: " + "\(maxValue)")
        
        let size:CGSize = CGSize(getWidth(),getHeight())
        points = GraphUtils.points(size, CGPoint(0,0), CGSize(100,100), vValues, maxValue,0,0)
        Swift.print("points: " + "\(points)")
        
        /*GraphPoints*/
        for i in 0..<points!.count{
            let pos:CGPoint = points![i]/*interpolates from one point to another*/
            graphDots[i].setPosition(pos)//moves the points
        }
        /*GraphLine*/
        let path:IPath = PolyLineGraphicUtils.path(points!)/*convert points to a Path*/
        //TODO: Ideally we should create the CGPath from the points use CGPathParser.polyline
        let cgPath = CGPathUtils.compile(CGMutablePath(), path)//convert path to cgPath
        graphLine!.line!.cgPath = cgPath.clone()//applies the new path
        graphLine!.line!.draw()//draws the path
    }
}
class GraphScrollView:ContainerView3,ElasticScrollable3{
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgress,self.maskSize,self.contentSize)
    override var maskSize:CGSize {return CGSize(super.getWidth(),super.getHeight())}/*Represents the visible part of the content *///TODO: could be ranmed to maskRect, say if you need x and y aswell
    override var contentSize:CGSize {return CGSize(100*19,super.getHeight())}
    var itemSize:CGSize {return CGSize(24,24)}
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     * //TODO: ⚠️️you need to make an scroolWheel method that you can override down hirarcy.
     */
    override func scrollWheel(with event:NSEvent) {//you can probably remove this method and do it in base?"!?
        //Swift.print("GraphAreaX.scrollWheel()")
        //(self as ICommitList).scroll(event)
        if(event.phase == NSEventPhase.changed){//this is only direct manipulation, not momentum
            Swift.print("moverGroup!.result.x: " + "\(moverGroup!.result.x)")
        }
        super.scrollWheel(with:event)/*⚠️️, 👈 not good, forward the event other delegates higher up in the stack*/
    }
}
//protocol GraphScrollable:Progressable3 {
//    
//}
//
//extension GraphScrollable{
//    var itemSize:CGSize {return CGSize(24,24)}
//}

