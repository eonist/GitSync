import Cocoa
@testable import Utils
@testable import Element
/**
 *
 */
class GraphAreaX:Element{
    var graphDots:[Element] = []
    var graphLine:GraphLine?
    var contentContainer:Element? {return scrollView?.contentContainer}/*contains dots and line*/
    var scrollView:GraphScrollView?
    var points:[CGPoint]?
    var prevPoints:[CGPoint]?/*interim var*/
    static var vValues:[CGFloat]?
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
     * Creates the initial graph CGPoint's
     */
    func createCGPoints(){
        let vValues:[CGFloat] = Array(repeating:0, count:GraphX.config.tCount)/*placeholder values*/
        let maxValue:CGFloat = 0
        points = GraphUtils.points(CGSize(w,h), CGPoint(0,0), CGSize(100,100), vValues, maxValue, 0, 0)
    }
    /**
     * Creates the Graph line
     */
    func createGraphLine(/*_ vValues:[CGFloat], _ maxValue:CGFloat*/){
        Swift.print("createGraphLine")
        graphLine = contentContainer!.addSubView(GraphLine(getWidth(),getHeight(),Path(),contentContainer!))
    }
    /**
     * Creates The visual Graph points that hover above the Graph line
     * NOTE: We could create something called GraphPoint, but it would be another thing to manager so instead we just use an Element with id: graphPoint
     */
    func createGraphPoints(){
        points!.forEach{
            let graphDot:Element = contentContainer!.addSubView(Element(NaN,NaN,contentContainer!,"graphPoint"))
            graphDots.append(graphDot)
            graphDot.setPosition($0)
        }
    }
    /**
     * Re-calc and set the graphPoint positions (for instance if the hValues has changed etc)
     */
    func updateGraph(_ vValues:[CGFloat]){
        //Swift.print("updateGraph.vValues: " + "\(vValues)")
        //prevPoints = points.map{$0}//grabs the location of where the pts are now
        GraphAreaX.vValues = vValues
        let maxValue:CGFloat = vValues.max()!//Finds the largest number in among vValues
        //Swift.print("maxValue: " + "\(maxValue)")
        
        let size:CGSize = CGSize(getWidth(),getHeight())
        points = GraphUtils.points(size, CGPoint(0,0), CGSize(100,100), vValues, maxValue,0,0)
        //Swift.print("points: " + "\(points)")
        
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



//protocol GraphScrollable:Progressable3 {
//    
//}
//
//extension GraphScrollable{
//    var itemSize:CGSize {return CGSize(24,24)}
//}

