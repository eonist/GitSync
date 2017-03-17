import Foundation
@testable import Element
@testable import Utils

class FindPointOnGraphTest:Element{
    override func resolveSkin() {
        super.resolveSkin()
        addGraphLine()
    }
    //make points
    //draw graph
    //find point
    //draw dot
}
extension FindPointOnGraphTest{
    func addGraphLine(){
        var css:String = "GraphLine{"
        css +=    "float:none;"
        css +=    "clear:none;"
        css +=    "line:#2AA3EF;"
        css +=    "line-alpha:1;"
        css +=    "line-thickness:0.5px;"
        css += "}"
        StyleManager.addStyle(css)
        typealias P = CGPoint
        let points:[P] = (0..<6).map{
            let x:CGFloat = 100*$0
            let y:CGFloat = (0..<(height.int-32)).random.cgFloat
            return P(x,y)
        }
        
        let path:IPath = PolyLineGraphicUtils.path(points)
        let graphLine = self.addSubView(GraphLine(width,height,path))
        _ = graphLine
    }
    /**
     *
     */
    func addGraphPoint(){
        addStyle()
        let graphPoint:Element = self.addSubView(Element(NaN,NaN,self,"graphPoint"))
        graphPoint.setPosition(CGPoint())
    }
    /**
     *
     */
    func addStyle(){
        /*GraphPoint*/
        var css:String = ""
        css += "Graph Section#graphArea #graphPoint{"
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
