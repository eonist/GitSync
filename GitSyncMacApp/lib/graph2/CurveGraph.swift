import Foundation
@testable import Utils
@testable import Element
//list of points

//the control points are the radius

//5 graph points

//find point on curve for x formula

//find start and end and do the squezing scheme

//looks good? move the graph into a crop in the center

//add a proxy curve with gradient and butt ends


class CurveGraph:Element{
    typealias P = CGPoint
    var points:[CGPoint]?
    var graphLine:GraphLine?
    
    override func resolveSkin() {
        super.resolveSkin()
        
        //Draw a curve
        addGraphLine()
    }
}

extension CurveGraph{
    func addGraphLine(){
        addGraphLineStyle()
        
        
        let h:Int = height.int
        let w:CGFloat = 100
        var commands:[Int] = [PathCommand.moveTo]
        var pathData:[CGFloat] = [points[0].x,points[0].y]
        
        points = (0...5).map{
            let x:CGFloat = w*$0
            let y:CGFloat = (0..<h).random.cgFloat
            let cp1:P = P()
            let cp2:P = P()
            let a:P = P(x,y)
            return P(x,y)
        }
        
        
        let path:IPath = PolyLineGraphicUtils.path(points!)
        graphLine = self.addSubView(GraphLine(width,height,path))
    }
    static func path(_ points:[CGPoint]) -> IPath {
        
        for i in 1..<points.count{//swift 3 update
            commands.append(PathCommand.cubicCurveTo)
            let p:CGPoint = points[i]
            pathData += [p.x,p.y]
        }
        return Path(commands, pathData)
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
}
