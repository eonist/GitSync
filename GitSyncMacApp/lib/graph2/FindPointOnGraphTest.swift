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
}
