import Cocoa
@testable import Utils
@testable import Element
/**
 * A Graph that modulates the graph while you scroll
 */
class GraphAreaX:Element,GraphAreaKind{
    lazy var scrollView:GraphScrollView4 = createScrollView4()//createScrollView3()//createScrollView()
    lazy var points:[CGPoint] = createCGPoints()
    lazy var graphDots:[Element] = createGraphPoints()
    lazy var graphLine:GraphLine = createGraphLine()
    var contentContainer:Element {return scrollView.contentContainer}/*contains dots and line*/
//    var vValues:[CGFloat] = []
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
        _ = points
        _ = scrollView
        _ = contentContainer
//        _ = contentContainer.addSubView(Section(100*19,getHeight(),contentContainer,"bg"))
        //scrollView?.contentContainer = contentContainer!
        
        contentContainer.addSubview(graphLine)
        _ = graphDots
    }
    func item(at: Int) -> Int? {//this is just for compliance, this class is deprecated
        return nil
    }
    var count: Int {return 0}//this is just for compliance, this class is deprecated
}
//lazy creators
extension GraphAreaX{
    /**
     * New
     * TODO: ⚠️️ add item spacing probably as a method argument: 100
     */
    static func points(vValues:[CGFloat],size:CGSize)->[CGPoint]{//make private?
        guard let maxValue:CGFloat = vValues.max() else {fatalError("err: \(vValues.count)")}/*Finds the largest number in among vValues*/
        let config:GraphUtils.GraphConfig = GraphUtils.GraphConfig(size: size, position: CGPoint(0,0), spacing: CGSize(100,100), vValues: vValues, maxValue: maxValue, leftMargin: 0, topMargin: 0)
        return GraphUtils.points(config:config)//TODO: ⚠️️ don't use config as arg. config as arg is great when the arg is uses from manny callers. but this is only used rfom one place.
    }
    /**
     *
     */
    func createScrollView4() -> GraphScrollView4{
        let size = CGSize(getWidth(),getHeight())
        let view = GraphScrollView4.init(graphArea: self, size: size)
        return addSubView(view)
    }
//    func createScrollView3() -> GraphScrollView3{
//        let dp:DP = DP.init(Array.init(repeating: ["":""], count: GraphX.config.totCount))
//        let listConfig = List5.Config.init(itemSize: CGSize(100,getHeight()), dp: dp, dir: .hor)
//        let list = GraphScrollView3.init(graphArea:self,points:points,config:listConfig, size:CGSize(getWidth(),getHeight()))
//        return addSubView(list)
//    }
//    func createScrollView() -> GraphScrollView2{
//        return addSubView(GraphScrollView2.init(graphArea:self,size:CGSize(getWidth(),getHeight())))
//    }
    /**
     * Creates the initial graph CGPoint's
     */
    func createCGPoints() -> [CGPoint]{
//        let vValues:[CGFloat] = Array(repeating:0, count:GraphX.config.totCount)/*placeholder values*/
        let vValues:[CGFloat] = GraphUtils.randomVerticalValues(count:GraphX.config.totCount,min:0,max:140)
        return GraphAreaX.points(vValues:vValues,size:CGSize(getWidth(), getHeight()))
//        let maxValue:CGFloat = 0
//        let config:GraphUtils.GraphConfig = GraphUtils.GraphConfig(size: CGSize(w,h), position: CGPoint(0,0), spacing: CGSize(100,100), vValues: vValues, maxValue: maxValue, leftMargin: 0, topMargin: 0)
//        return GraphUtils.points(config:config)
    }
    /**
     * Creates the Graph line
     */
    func createGraphLine(/*_ vValues:[CGFloat], _ maxValue:CGFloat*/) -> GraphLine{
        let pointsWithin:[CGPoint] = GraphScrollerHandler3.Utils.calcPointsWithin(x: scrollView.x, width: scrollView.width, points: points)
        let path:PathKind = PolyLineGraphicUtils.path(pointsWithin)/*convert points to a Path*/
        //TODO: ⚠️️ Ideally we should create the CGPath from the points use CGPathParser.polyline
//                let cgPath = CGPathUtils.compile(CGMutablePath(), path)//convert path to cgPath
//                graphLine.line!.cgPath = CGPathParser.polyLine(points)//cgPath.clone()//applies the new path
//                graphLine.line!.draw()//draws the path
        let graphicLine = GraphLine(getWidth(),getHeight(),path,contentContainer)
        graphicLine.line?.draw()
        return graphicLine
    }
    /**
     * Creates The visual Graph points that hover above the Graph line
     * NOTE: We could create something called GraphPoint, but it would be another thing to manager so instead we just use an Element with id: graphPoint
     */
    func createGraphPoints() -> [Element] {
        let pts = GraphScrollerHandler3.Utils.calcPointsWithin(x: 0, width: getWidth(), points: points)
        return pts.map{/*_ in*/
            let graphDot:Element = contentContainer.addSubView(Element(0,0,contentContainer,"graphPoint"))
//            GraphAreaX.graphDots.append(graphDot)
            graphDot.layer?.position = ($0)
            return graphDot
        }
    }
    //continue here: 🏀
        //add the above GraphPoint to The ListItems. and make sure your css is correct too 👈
}

//protocol GraphScrollable:Progressable3 {
//    
//}
//
//extension GraphScrollable{
//    var itemSize:CGSize {return CGSize(24,24)}
//}



//    /**
//     * Re-calc and set the graphPoint positions (for instance if the hValues has changed etc)
//     */
//    func updateGraph(_ vValues:[CGFloat]){
//        //Swift.print("updateGraph.vValues: " + "\(vValues)")
//        //prevPoints = points.map{$0}//grabs the location of where the pts are now
////        self.vValues = vValues
//
//        points = GraphAreaX.points(vValues:vValues,size:CGSize(getWidth(), getHeight()))
//
//        /*Update graph points*/
//        for i in 0..<points.count{
//            let pos:CGPoint = points[i]/*Interpolates from one point to another*/
//            _ = pos
////            graphDots[i].layer?.position = pos/*Moves the points*/
//        }
//        /*Update graph lines*/
//
//    }
