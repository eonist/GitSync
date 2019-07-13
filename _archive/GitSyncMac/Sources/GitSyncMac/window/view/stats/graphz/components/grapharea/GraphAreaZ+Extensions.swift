import Cocoa
@testable import Utils
@testable import Element
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
        Swift.print("createCGPoints")
        let x:CGFloat = 0//init pos.x of graph
        let rect = CGRect(0,0,getWidth(), getHeight())
//        Swift.print("rect: " + "\(rect)")
        Swift.print("count: " + "\(count)")
        let totContentWidth:CGFloat = count * GraphZ.config.itemSize.w
        Swift.print("totContentWidth: " + "\(totContentWidth)")
        let idxRange:(start:Int,end:Int) = GraphZUtils.idxRange(x: x, totWidth: totContentWidth, itemWidth: GraphZ.config.itemSize.w, totCount: count, visibleCount: self.visibleCount)
        //        idxRange.end = idxRange.end + 2
        Swift.print("idxRange: " + "\(idxRange)")
        vValues = GraphZUtils.vValues(idxRange: idxRange, itemAt: self.item)
        //        Swift.print("vValues.count: " + "\(vValues?.count)")
        let maxVValue:Int = vValues!.max()!//Finds the largest number in among vValues
        //        Swift.print("maxVValue: " + "\(maxVValue)")
        let pts = GraphZUtils.points(idxRange:idxRange, vValues: vValues!, maxValue: maxVValue,rect:rect, spacing:GraphZ.config.itemSize)
        Swift.print("pts.count: " + "\(pts.count)")
//        Swift.print("pts: " + "\(pts)")
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
        //(0..<(points.count+2)).indices.map{ _ in
        return points.map {
            let graphDot:Element = contentContainer.addSubView(Element(size:CGSize(0,0),id:"graphPoint"))
//            graphDot.layer!.position = ($0)
            graphDot.frame.origin = ($0)//strange 🤔
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
