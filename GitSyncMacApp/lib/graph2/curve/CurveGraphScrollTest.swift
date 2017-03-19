import Cocoa
@testable import Utils
@testable import Element

//scale the cruvegraph
//find the dot points
//add dot points to array of points within visual field
//find min y from these points
//find the dif between bottom.y and min y
//find the ratio between height and diff
//scale a line graph with a point scale with the new ratio
//take it for a spin

class CurveGraphScrollTest:ContainerView2{
    typealias P = CGPoint
    var points:[CGPoint] = []
    var graphPoint1:Element?
    var graphPoint2:Element?
    var graphLine:GraphLine?
    var space:CGFloat = 200/*x space between points*/
    
    override var itemSize:CGSize {return CGSize(100,100)}//override this for custom value
    override var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    override var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    /**
     * 🔨 Setup
     */
    override func resolveSkin() {
        StyleManager.addStyle("CurveGraphScrollTest{float:none;clear:none;fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        /*config*/
        maskSize = CGSize(width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentSize = CGSize(1800,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        
        addGraphLine()
        addGraphPoint()
    }
}
extension CurveGraphScrollTest{
    override func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaX, interval, progress)
        setProgress(progressVal)
    }
    /**
     * 🚗 SetProgress
     */
    func setProgress(_ progress:CGFloat){
        let x:CGFloat = ScrollableUtils.scrollTo(progress, maskSize.w, contentSize.w)
        Swift.print("x: " + "\(x)")
        contentContainer!.x = x
        
        /*gp1*/
        let x1:CGFloat = -1 * x
        let y1:CGFloat = findGraphP(x1,points).y
        graphPoint1!.point = P(0,y1)
        /*gp2*/
        let x2:CGFloat = (-1 * x) + width
        let y2:CGFloat = findGraphP(x2,points).y
        graphPoint2!.point = P(width,y2)
        
    }
}
extension CurveGraphScrollTest{
    /**
     * 🐍 GraphLine
     */
    func addGraphLine(){
        addGraphLineStyle()
        let path:IPath = self.path(space,9)
        graphLine = contentContainer!.addSubView(GraphLine(width,height,path))
    }
    func path(_ space:CGFloat, _ num:Int)->IPath{
        let h:Int = height.int
        let w:CGFloat = space
        let rad:CGFloat = w/2
        var commands:[Int] = [PathCommand.moveTo]
        let y0:CGFloat = (0..<h).random.cgFloat
        var pathData:[CGFloat] = [0,y0]
        var prevEnd:P = P(0,y0)
        points.append(prevEnd)
        (1...num).forEach{ i in
            let x:CGFloat = w * i
            //let y:CGFloat = (0..<h).random.cgFloat
            let y:CGFloat = (0..<(h*4)).random.cgFloat - (h.cgFloat * 3)
            let a:P = P(x,y)
            points.append(a)
            let cp1:P = P(prevEnd.x+rad,prevEnd.y)
            let cp2:P = P(a.x-rad,a.y)
            pathData += [a.x,a.y,cp1.x,cp1.y,cp2.x,cp2.y]
            let cmd:Int = PathCommand.cubicCurveTo
            commands.append(cmd)
            prevEnd = a
        }
        
        let path:IPath = Path(commands, pathData)
        return path
    }
    
    /**
     * 🎯 GraphPoint
     */
    func addGraphPoint(){
        /*gp1*/
        addGraphPointStyle()
        
        let p = findGraphP(0,points)
         Swift.print("-p-: " + "\(p)")
         
         graphPoint1 = self.addSubView(Element(NaN,NaN,self,"graphPoint"))
         graphPoint1!.setPosition(p)
        /*gp2*/
        let p2 = findGraphP(width,points)
        Swift.print("-p2-: " + "\(p2)")
        graphPoint2 = self.addSubView(Element(NaN,NaN,self,"graphPoint"))
        graphPoint2!.point = p2
    }
    
}
extension CurveGraphScrollTest{
    /**
     *
     */
    func findGraphP(_ x:CGFloat, _ points:[P])->P{
        Swift.print("x: " + "\(x)")
        Swift.print("points.count: " + "\(points.count)")
        var seg:(p1:P,p2:P)?
        for i in 0..<points.count-1{
            let cur = points[i]
            let next = points[i+1]
            if(x >= cur.x && x <= next.x){//within
                seg = (cur,next)
                break
            }
        }
        //seg = seg ?? (points[points.count-2],points.last!)
        Swift.print("seg: " + "\(seg)")
        
        let cb:CubicBezier = self.cubicBezier(seg!.p1,seg!.p2,space)
        let p = CubicCurveUtils.point(cb.p0,cb.c0,cb.c1,cb.p1,x)
        
        return p
    }
    /**
     *
     */
    typealias CubicBezier = (p0:P,p1:P,c0:P,c1:P)
    func cubicBezier(_ start:P, _ end:P, _ space:CGFloat) -> CubicBezier{
        let c0:P = P(start.x + (space/2),start.y)
        let c1:P = P(end.x - (space/2), end.y)
        return (start,end,c0,c1)
    }
}
/**
 * 🎨 Styles
 */
extension CurveGraphScrollTest{
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
