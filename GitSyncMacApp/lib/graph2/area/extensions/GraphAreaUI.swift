import Foundation
@testable import Element
@testable import Utils

extension GraphComponent{
    /**
     * Creates the UI Components
     */
    func createUI(){
        createGraphLine()
        createGraphPoints()
        createVLines()
    }
    /**
     * Creates the Graph line
     */
    func createGraphLine(/*_ vValues:[CGFloat], _ maxValue:CGFloat*/){
        let vValues:[CGFloat] = Array(repeating: 0, count: Graph9.config.tCount)/*placeholder values*/
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
            dots.append(graphPoint)
            graphPoint.setPosition($0)
        }
    }
    /**
     * Vertical lines (static)
     */
    func createVLines(/*_ size:CGSize,_ position:CGPoint,_ spacing:CGSize*/){
        let size:CGSize = CGSize(w,h)
        let count:Int = Graph9.config.tCount
        let spacing:CGSize = CGSize(100,100)
        let leftMargin:CGFloat = 0
        let rightMargin:CGFloat = 0
        _ = rightMargin
        let topMargin:CGFloat = 0
        let bottomMargin:CGFloat = 0
        let vLineHeight:CGFloat = size.height - topMargin - bottomMargin
        var x:CGFloat = leftMargin
        let y:CGFloat = topMargin
        for _ in 0..<count{
            let vLine = /*graphArea!*/self.addSubView(Element(NaN,vLineHeight,self/*graphArea*/,"vLine"))
            vLine.setPosition(CGPoint(x,y))
            x += spacing.width
        }
    }
}
