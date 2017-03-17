import Cocoa
@testable import Element
@testable import Utils

class GraphView2:ContainerView2{
    typealias P = CGPoint
    var points:[CGPoint]?
    var graphPoint1:Element?
    var graphPoint2:Element?
    var edgeValues:(start:CGFloat,end:CGFloat)?
    
    override var itemSize:CGSize {return CGSize(48,48)}//override this for custom value
    override var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    override var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    
    override func resolveSkin() {
        StyleManager.addStyle("GraphView2{float:left;clear:left;fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        /*config*/
        maskSize = CGSize(width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentSize = CGSize(1600,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        
        contentContainer = addSubView(Container(width,height,self,"content"))
        addGraphLine()
        addGraphPoint()
        let minX:CGFloat = 0
        let maxX:CGFloat = width
        
        let minY:CGFloat = self.minY(minX,maxX)
        Swift.print("⚠️️ minY: " + "\(minY))")
    }
}
extension GraphView2{
    /**
     * 
     */
    func minY(_ minX:CGFloat,_ maxX:CGFloat) -> CGFloat {
        return ([edgeValues!.start, edgeValues!.end] + points!.filter{$0.x >= minX && $0.x <= maxX}.map{$0.y}).min()!
    }
    /**
     *
     */
    func addGraphLine(){
        addGraphLineStyle()
        let h:Int = height.int
        points = (0..<18).map{
            let x:CGFloat = 100*$0
            let y:CGFloat = (0..<(h*2)).random.cgFloat - h.cgFloat
            return P(x,y)
        }
        
        let path:IPath = PolyLineGraphicUtils.path(points!)
        let graphLine = contentContainer!.addSubView(GraphLine(width,height,path))
        _ = graphLine
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
/*Animation*/
extension GraphView2{
    override func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaX, interval, progress)
        setProgress(progressVal)
    }
    func setProgress(_ progress:CGFloat){
        let x:CGFloat = ScrollableUtils.scrollTo(progress, maskSize.w, contentSize.w)
        Swift.print("x: " + "\(x)")
        contentContainer!.x = x
        /*gp1*/
        let x1:CGFloat = -1 * x
        let y1:CGFloat = findY(x1,points!)
        graphPoint1!.point = P(0,y1)
        /*gp2*/
        let x2:CGFloat = (-1 * x) + width
        let y2:CGFloat = findY(x2,points!)
        graphPoint2!.point = P(width,y2)
        edgeValues = (y1,y2)
        /**/
        let minX:CGFloat = x1
        let maxX:CGFloat = x2
        let minY:CGFloat = self.minY(minX,maxX)
        Swift.print("⚠️️ minY: " + "\(minY))")
    }
}

extension GraphView2{
    func addGraphPoint(){
        /*gp1*/
        let x:CGFloat = 0
        let p = findGraphP(x,points!)
        Swift.print("-p-: " + "\(p)")
        
        addGraphPointStyle()
        graphPoint1 = self.addSubView(Element(NaN,NaN,self,"graphPoint"))
        graphPoint1!.setPosition(p)
        /*gp2*/
        let x2:CGFloat = width
        let p2 = findGraphP(x2,points!)
        Swift.print("-p2-: " + "\(p2)")

        graphPoint2 = self.addSubView(Element(NaN,NaN,self,"graphPoint"))
        graphPoint2!.setPosition(p2)
        
        edgeValues = (p.y,p2.y)
    }
    
    /**
     *
     */
    func findGraphP(_ x:CGFloat, _ points:[P]) -> P{
        let y:CGFloat = findY(x,points)
        let p:P = P(x,y)
        return p
    }
    /**
     *
     */
    func findY(_ x:CGFloat, _ points:[P])->CGFloat{
        //Swift.print("x: " + "\(x)")
        var seg:(p1:P,p2:P)?
        for i in 0..<points.count-1{
            let cur = points[i]
            let next = points[i+1]
            if(x >= cur.x && x <= next.x){//within
                seg = (cur,next)
                break
            }
        }
        Swift.print("seg: " + "\(seg)")
        let slope:CGFloat = CGPointParser.slope(seg!.p1, seg!.p2)
        Swift.print("slope: " + "\(slope)")
        let y:CGFloat = CGPointParser.y(seg!.p1, x, slope)/*seg!.p2.x*/
        return y
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
