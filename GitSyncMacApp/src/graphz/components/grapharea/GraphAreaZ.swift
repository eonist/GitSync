import Cocoa
@testable import Utils
@testable import Element
/**
 * A Graph that modulates the graph while you scroll
 */
class GraphAreaZ:Element,GraphAreaKind {
    lazy var scrollView:GraphScrollView5 = createScrollView()
    lazy var points:[CGPoint] = createCGPoints()//rename to curPoints ⚠️️
    var vValues:[Int]?
    lazy var graphDots:[Element] = createGraphPoints()
    lazy var graphLine:GraphLine = createGraphLine()
    var contentContainer:Element {return scrollView.contentContainer}/*contains dots and line*/
    var prevPoints:[CGPoint]?/*interim var*/
    let graphZ:GraphZ
    let visibleCount:Int = 7
    func item(at: Int) -> Int? {//this is just for compliance, this class is deprecated
        return graphZ.dp.item(at:at)
    }
    var count: Int {return graphZ.dp.count}
//    var count: Int {return graphZ.dp.count.clip(self.visibleCount-1, graphZ.dp.count) }/*Tot count of all items in dp*///we clip it to avoid visual bugs. -1 strangly enough works.
    lazy var maxCommitCount:Int = {graphZ.dp.dp.commitCount.values.max() ?? {fatalError("err")}()}()//max commitCount in the entire dp

    init(graphZ:GraphZ, size:CGSize, id:String? = nil) {
        self.graphZ = graphZ
        super.init(size: size, id: id)
    }
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
        contentContainer.addSubview(graphLine)
        _ = graphDots
    }
    override func getClassType() -> String {
        return "GraphArea"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
//lazy creators
extension GraphAreaZ{
    /**
     * Creates ScrollView
     */
    func createScrollView() -> GraphScrollView5 {
        let size = CGSize(getWidth(),getHeight())
        let view = GraphScrollView5.init(graphArea: self, size: size)
        return addSubView(view)
    }
    /**
     * Creates the initial graph CGPoint's
     */
    func createCGPoints() -> [CGPoint]{
        let x:CGFloat = 0//init pos.x of graph
        let rect = CGRect(0,0,getWidth(), getHeight())
        Swift.print("rect: " + "\(rect)")
        Swift.print("count: " + "\(count)")
        let totContentWidth:CGFloat = count * GraphZ.config.itemSize.w
        Swift.print("totContentWidth: " + "\(totContentWidth)")
        let idxRange:(start:Int,end:Int) = GraphZUtils.idxRange(x: x, width: totContentWidth, itemWidth: GraphZ.config.itemSize.w, totCount: count, visibleCount: self.visibleCount)
        vValues = GraphZUtils.vValues(idxRange: idxRange, itemAt: self.item)
        Swift.print("vValues.count: " + "\(vValues?.count)")
        let maxVValue:Int = vValues!.max()!//Finds the largest number in among vValues
//        Swift.print("maxVValue: " + "\(maxVValue)")
        let pts = GraphZUtils.points(idxRange:idxRange, vValues: vValues!, maxValue: maxVValue,rect:rect, spacing:GraphZ.config.itemSize)
        Swift.print("pts: " + "\(pts)")
        return pts
    }
    /**
     * Creates the Graph line
     */
    func createGraphLine(/*_ vValues:[CGFloat], _ maxValue:CGFloat*/) -> GraphLine{
        let path:PathKind = PolyLineGraphicUtils.path(points)/*convert points to a Path*/
        let graphicLine = GraphLine(getWidth(),getHeight(),path,contentContainer)
        graphicLine.line?.draw()
        return graphicLine
    }
    /**
     * Creates The visual Graph points that hover above the Graph line
     * NOTE: We could create something called GraphPoint, but it would be another thing to manager so instead we just use an Element with id: graphPoint
     */
    func createGraphPoints() -> [Element] {
        return points.map{/*_ in*/
            let graphDot:Element = contentContainer.addSubView(Element(0,0,contentContainer,"graphPoint"))
            graphDot.layer?.position = ($0)
            return graphDot
        }
    }
    /**
     * UpdateGraph (Updates both graphDot's and graphLine)
     */
    func updateGraph(pts:[CGPoint]){
        /*updateGraphDots*/
        let newPts:[CGPoint] = self.graphDots.enumerated().flatMap { (i,graphDot) in
            if let pt = pts[safe:i] {
                graphDot.isHidden = false
                graphDot.layer?.position = pt
                return pt
            }else{//dirty fix
                graphDot.isHidden = true
                return nil
            }
        }
        /*updateGraphLine*/
        graphLine.line!.cgPath = CGPathParser.polyLine(newPts)
        graphLine.line!.draw()/*draws the path*/
    }
}
