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
        let rad:CGFloat = w/2
        var commands:[Int] = [PathCommand.moveTo]
        let y0:CGFloat = (0..<h).random.cgFloat
        var pathData:[CGFloat] = [0,y0]
        
        (0...5).forEach{ i in
            let x:CGFloat = w * i
            let y:CGFloat = (0..<h).random.cgFloat
            let a:P = P(x,y)
            let cp1:P = P(a.x-rad,a.y)
            let cp2:P = P(a.x+rad,a.y)
            pathData += [a.x,a.y,cp1.x,cp1.y,cp2.x,cp2.y]
            let cmd:Int = PathCommand.cubicCurveTo
            commands.append(cmd)
        }
        
        let path:IPath = Path(commands, pathData)
        graphLine = self.addSubView(GraphLine(width,height,path))
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
