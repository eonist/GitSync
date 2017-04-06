import Foundation
@testable import Utils
@testable import Element

class GraphComponent:Element {//alternate name? GraphArea?
    var graphPoints:[Element]?//rename to graphDots for clearity?
    var graphLine:GraphLine?
    var contentContainer:Element?//remove?
    /*Anim*/
    var graphPts:[CGPoint]?
    var prevGraphPts:[CGPoint]?/*interim var*/
    var animator:Animator?
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync/stats/graphcomponent.css")
        super.resolveSkin()
        contentContainer = addSubView(Container(width,height,self,"content"))
        createGraphLine()
        createGraphPoints()
        createVLines()
    }
}
/*Update*/
extension GraphComponent{
    /**
     * Re-calc and set the graphPoint positions (for instance if the hValues has changed etc)
     */
    func updateGraph(_ vValues:[CGFloat]){
        prevGraphPts = graphPts.map{$0}//grabs the location of where the pts are now
        let maxValue:CGFloat = vValues.max()!//Finds the largest number in among vValues
        graphPts = GraphUtils.points(CGSize(w,h), CGPoint(0,0), CGSize(100,100), vValues, maxValue,Graph9.config.margin.width,Graph9.config.margin.height)
        /*GraphPoints*/
        if(animator != nil){animator!.stop()}/*stop any previous running animation*/
        animator = Animator(Animation.sharedInstance,0.5,0,1,interpolateValue,Quad.easeIn)
        animator!.start()
    }
}
/*UI*/
extension GraphComponent{
    /**
     * Creates the Graph line
     */
    func createGraphLine(/*_ vValues:[CGFloat], _ maxValue:CGFloat*/){
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
        let size:CGSize = CGSize(w,h)
        let count:Int = Graph9.config.tCount
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
extension GraphComponent{
    /**
     * Interpolates between 0 and 1 while the duration of the animation
     * NOTE: ReCalc the hValue indicators (each week has a different max hValue etc)
     */
    func interpolateValue(_ val:CGFloat){
        //Swift.print("interpolateValue() val: " + "\(val)")
        var positions:[CGPoint] = []
        /*GraphPoints*/
        for i in 0..<graphPts!.count{
            let pos:CGPoint = prevGraphPts![i].interpolate(graphPts![i], val)/*interpolates from one point to another*/
            positions.append(pos)
            graphPoints![i].setPosition(pos)//moves the points
        }
        /*GraphLine*/
        let path:IPath = PolyLineGraphicUtils.path(positions)/*convert points to a Path*/
        //TODO: Ideally we should create the CGPath from the points use CGPathParser.polyline
        let cgPath = CGPathUtils.compile(CGMutablePath(), path)//convert path to cgPath
        graphLine!.line!.cgPath = cgPath.clone()//applies the new path
        graphLine!.line!.draw()//draws the path
    }

}
