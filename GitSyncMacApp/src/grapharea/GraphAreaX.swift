import Cocoa
@testable import Utils
@testable import Element
/**
 * A Graph that modulates the graph while you scroll
 */

//Continue here: 🏀
    //clean up this class. upgrade to Container5, ✅
    //then Maybe ElasticCOntainer5 ✅
    //use v5 in createScrollView, then test

class GraphAreaX:Element{
    lazy var scrollView:GraphScrollView2 = createScrollView()
    lazy var points:[CGPoint] = createCGPoints()
    lazy var graphDots:[Element] = createGraphPoints()
    lazy var graphLine:GraphLine = createGraphLine()
    //
    var contentContainer:Element {return scrollView.contentContainer}/*contains dots and line*/
    var vValues:[CGFloat] = []
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
        _ = scrollView
        _ = contentContainer.addSubView(Section(100*19,getHeight(),contentContainer,"bg"))
        //scrollView?.contentContainer = contentContainer!
        _ = points
        _ = graphLine
        _ = graphDots
    }
    /**
     * Re-calc and set the graphPoint positions (for instance if the hValues has changed etc)
     */
    func updateGraph(_ vValues:[CGFloat]){
        //Swift.print("updateGraph.vValues: " + "\(vValues)")
        //prevPoints = points.map{$0}//grabs the location of where the pts are now
        self.vValues = vValues
        let maxValue:CGFloat = vValues.max()!//Finds the largest number in among vValues
        //Swift.print("maxValue: " + "\(maxValue)")
        
        let size:CGSize = CGSize(getWidth(), getHeight())
        points = GraphUtils.points(size, CGPoint(0,0), CGSize(100,100), vValues, maxValue,0,0)
        //Swift.print("points: " + "\(points)")
        
        /*Update graph points*/
        for i in 0..<points.count{
            let pos:CGPoint = points[i]/*Interpolates from one point to another*/
            graphDots[i].layer?.position = (pos)/*Moves the points*/
        }
        /*Update graph lines*/
        //let path:IPath = PolyLineGraphicUtils.path(points!)/*convert points to a Path*/
        //TODO: ⚠️️ Ideally we should create the CGPath from the points use CGPathParser.polyline
        //let cgPath = CGPathUtils.compile(CGMutablePath(), path)//convert path to cgPath
        graphLine.line!.cgPath = CGPathParser.polyLine(points)//cgPath.clone()//applies the new path
        graphLine.line!.draw()//draws the path
    }
}
extension GraphAreaX{
    func createScrollView() -> GraphScrollView2{
        return addSubView(GraphScrollView2.init(graphArea:self,size:CGSize(getWidth(),getHeight())))
    }
    /**
     * Creates the initial graph CGPoint's
     */
    func createCGPoints() -> [CGPoint]{
        let vValues:[CGFloat] = Array(repeating:0, count:GraphX.config.tCount)/*placeholder values*/
        let maxValue:CGFloat = 0
        return GraphUtils.points(CGSize(w,h), CGPoint(0,0), CGSize(100,100), vValues, maxValue, 0, 0)
    }
    /**
     * Creates the Graph line
     */
    func createGraphLine(/*_ vValues:[CGFloat], _ maxValue:CGFloat*/) -> GraphLine{
        Swift.print("createGraphLine")
        return contentContainer.addSubView(GraphLine(getWidth(),getHeight(),Path(),contentContainer))
    }
    /**
     * Creates The visual Graph points that hover above the Graph line
     * NOTE: We could create something called GraphPoint, but it would be another thing to manager so instead we just use an Element with id: graphPoint
     */
    func createGraphPoints() -> [Element] {
        return points.map{_ in
            let graphDot:Element = contentContainer.addSubView(Element(NaN,NaN,contentContainer,"graphPoint"))
//            GraphAreaX.graphDots.append(graphDot)
            return graphDot
            //graphDot.setPosition($0)
        }
    }

}

//protocol GraphScrollable:Progressable3 {
//    
//}
//
//extension GraphScrollable{
//    var itemSize:CGSize {return CGSize(24,24)}
//}

