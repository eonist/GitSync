import Foundation
@testable import Utils
@testable import Element

class GraphComponent:Element {
    override func resolveSkin() {
        super.resolveSkin()
        createGraphLine()
        createGraphPoints()
        createVLines()
    }
}
extension GraphComponent{
    /**
     * Creates the Graph line
     */
    func createGraphLine(/*_ vValues:[CGFloat], _ maxValue:CGFloat*/){
        //addGraphLineStyle()
        //graphPts = GraphTools.randomGraphPoints(50,100,h-100)
        let vValues:[CGFloat] = Array(repeating: 0, count: 7)
        let maxValue:CGFloat = 0
        graphPts = GraphUtils.points(CGSize(w,h), CGPoint(0,0), CGSize(100,100), vValues, maxValue, 50, 50)
        let path:IPath = PolyLineGraphicUtils.path(graphPts!)
        graphLine = contentContainer!.addSubView(GraphLine(width,height,path,contentContainer!))
    }
    /**
     * Creates The visual Graph points that hover above the Graph line
     * NOTE: We could create something called GraphPoint, but it would be another thing to manager so instead we just use an Element with id: graphPoint
     */
    func createGraphPoints(){
        //addGraphPointStyle()
        /**/
        graphPoints = []//what is this?
        graphPts!.forEach{
            let graphPoint:Element = contentContainer!.addSubView(Element(NaN,NaN,contentContainer!,"graphPoint"))
            graphPoints!.append(graphPoint)
            graphPoint.setPosition($0)
        }
    }
    /**
     * Vertical lines (static)
     */
    func createVLines(/*_ size:CGSize,_ position:CGPoint,_ spacing:CGSize*/){
        //addGraphVLineStyle()
        /**/
        let size:CGSize = CGSize(w,h)
        let count:Int = 7/*hValNames.count*/
        let spacing:CGSize = CGSize(100,100)
        let leftMargin:CGFloat = 50
        let topMargin:CGFloat = 50
        let bottomMargin:CGFloat = 50
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
