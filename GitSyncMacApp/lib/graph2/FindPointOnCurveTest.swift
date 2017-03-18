import Foundation
@testable import Utils
@testable import Element

class FindPointOnCurveTest:Element{
    typealias P = CGPoint
    override func resolveSkin() {
        super.resolveSkin()
        addGraphLine()
        addGraphPoint()
    }
}
extension FindPointOnGraphTest{
    func addGraphLine(){
        addGraphLineStyle()
        
        var p0 = P(0,100)  // The first point on curve
        let c0 = P(100,0)   // Controller for p0
        let c1 = P(100,150) // Controller for p1
        let p1 = P(200,50)  // The last point on curve
        
        let pathData:[CGFloat] = [p0.x,p0.y,p1.x,p1.y,c0.x,c0.y,c1.x,c1.y]
        let commands:[Int] = [PathCommand.moveTo,PathCommand.cubicCurveTo]
        let path:IPath = Path(pathData,commands)
        let graphLine = self.addSubView(GraphLine(width,height,path))
        _ = graphLine
    }
    /**
     *
     */
    func addGraphPoint(){
        addGraphPointStyle()
        let p = P(100,100)
        
        
        let graphPoint:Element = self.addSubView(Element(NaN,NaN,self,"graphPoint"))
        graphPoint.setPosition(p)
    }
    /**
     *
     */
    func addGraphLineStyle(){
        var css:String = "GraphLine{"
        css +=    "float:none;"
        css +=    "clear:none;"
        css +=    "line:#2AA3EF;"
        css +=    "line-alpha:1;"
        css +=    "line-thickness:0.5px;"
        css += "}"
        StyleManager.addStyle(css)
    }
    /**
     *
     */
    func addGraphPointStyle(){
        
        /*GraphPoint*/
        var css:String = ""
        css += "Element#graphPoint{"
        css +=     "float:none;"
        css +=     "clear:none;"
        css +=     "fill:#128BF2,#192633;"
        css +=     "width:12px,11px;"
        css +=     "height:12px,11px;"
        css +=     "margin-left:-6px,-5.5px;"
        css +=     "margin-right:6px,5.5px;"
        css +=     "margin-top:-6px,-5.5px;"
        css +=     "margin-bottom:6px,5.5px;"
        css +=     "drop-shadow:drop-shadow(1px 90 #000000 0.3 0.5 0.5 0 0 false);"
        css +=     "corner-radius:6px,5.5px;"
        css += "}"
        StyleManager.addStyle(css)
    }
}
