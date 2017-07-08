import Foundation
@testable import Utils
@testable import Element

class GraphAreaX:Element{
    var graphDots:[Element] = []//rename to graphDots for clearity?
    var graphLine:GraphLine?
    var contentContainer:Element?//contains dots and line
    var points:[CGPoint]?
    var prevPoints:[CGPoint]?/*interim var*/
    //var animator:Animator?/*Anim*/
    override func resolveSkin() {
        super.resolveSkin()
        //createUI()
    }
    /**
     * Creates the UI Components
     */
    func createUI(){
        contentContainer = addSubView(Container(width,height,self,"content"))
        createGraphLine()
        //createGraphPoints()
    }
    /**
     * Creates the Graph line
     */
    func createGraphLine(/*_ vValues:[CGFloat], _ maxValue:CGFloat*/){
        let vValues:[CGFloat] = Array(repeating:0, count:GraphX.config.tCount)/*placeholder values*/
        let maxValue:CGFloat = 0
        points = GraphUtils.points(CGSize(w,h), CGPoint(0,0), CGSize(100,100), vValues, maxValue, 0, 0)
        let path:IPath = PolyLineGraphicUtils.path(points!)
        graphLine = contentContainer!.addSubView(GraphLine(width,height,path,contentContainer!))
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
}

