import Cocoa
@testable import Element
@testable import Utils
/**
 * This tests 🗜 scaling the graph chart 📈 as you scroll  
 */
class GraphView2:ContainerView2{
    typealias P = CGPoint
    var points:[CGPoint]?
    var graphPoint1:Element?/*Min graph point, left*/
    var graphPoint2:Element?/*Max graph point, right*/
    var edgeValues:(start:CGFloat,end:CGFloat)?
    var graphLine:GraphLine?
    
    override var itemSize:CGSize {return CGSize(100,100)}/*override this for custom value*/
    override var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    override var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    
    override var maskSize:CGSize {return CGSize(super.width,super.height)}/*Represents the visible part of the content *///TODO: could be ranmed to maskRect, say if you need x and y aswell
    override var contentSize:CGSize {return CGSize(3000,height)}
    
    var prevX:CGFloat = -100
    var prevPoints:[CGPoint]?/*interim var*/
    var newPoints:[CGPoint]?
    var animator:Animator?/*Anim*/
    
    override func resolveSkin() {
        StyleManager.addStyle("GraphView2{float:none;clear:none;fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        /*config*/
        
        addGraphLine()
        addGraphPoint()
        let minX:CGFloat = 0
        let maxX:CGFloat = self.width
        
        let minY:CGFloat = self.minY(minX,maxX)
        _ = minY
        //Swift.print("⚠️️ minY: " + "\(minY))")
        setProgress(0)/*init tick*/
    }
}
/*Animation*/
extension GraphView2{
    override func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        //Swift.print("GraphView2.onScrollWheelChange")
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaX, interval, progress)
        setProgress(progressVal)
    }
    
    /**
     * Moves the contentContainer in the x position, recalculates the modulated path and draws it
     */
    func setProgress(_ progress:CGFloat){
        //Swift.print("setProgress: progress: \(progress)")
        let x:CGFloat = ScrollableUtils.scrollTo(progress, maskSize.w, contentSize.w)
        //Swift.print("x: " + "\(x)")
        contentContainer!.x = x
       
        let absX = abs(x)
        if absX >= prevX + 100 {/*only redraw at every 100px*/
            Swift.print("if x:\(x)")
            tick(x)
            prevX = absX
        }else if absX < prevX{
            Swift.print("else if x: \(x)")
            tick(x)
            prevX = absX - 100
        }
        
    }
    
    //Continue here: 🏀
        //remove many of the log prints ✅
        //draw out how you want to solve the threshold ticks better, maybe with insp from snap? ✅
        //add AnimTo from points to points. You should have code for this as well 👌
    
    
    /**
     *
     */
    func tick(_ x:CGFloat){
        
        //Swift.print("tick: x: \(x)")
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
        //Swift.print("⚠️️ minY: " + "\(minY))")
        
        //let dist:CGFloat = 400.cgFloat.distance(to: minY)
        let diff:CGFloat = height + (-1 * minY)
        //Swift.print("🍏 diff: " + "\(diff)")
        
        let ratio:CGFloat = height / diff
        prevPoints = newPoints ?? (0...30).map{P($0*100,0)}

        newPoints = points!.map{CGPointModifier.scale($0, P($0.x,height), P(1,ratio))}
        
        
        /*initAnim*/
        if(animator != nil){animator!.stop()}/*stop any previous running animation*/
        animator = Animator(Animation.sharedInstance,0.7,0,1,interpolateValue,Bounce.easeInOut)
        animator!.start()
        Swift.print("start anim")
        
    }
   
    /**
     * Interpolates between 0 and 1 while the duration of the animation
     * NOTE: ReCalc the hValue indicators (each week has a different max hValue etc)
     */
    func interpolateValue(_ val:CGFloat){
        /*newPoints!.forEach{
         //Swift.print("$0: " + "\($0)")
         graphPoint2!.point = $0
         }*/
        var positions:[CGPoint] = []
        /*GraphPoints*/
        for i in 0..<newPoints!.count{
            let pos:CGPoint = prevPoints![i].interpolate(newPoints![i], val)/*interpolates from one point to another*/
            positions.append(pos)
            
        }
        
        
        let path:IPath = PolyLineGraphicUtils.path(positions)
        graphLine!.line!.cgPath = CGPathUtils.compile(CGMutablePath(), path)
        graphLine!.line!.draw()//draws the path//TODO: ⚠️️ it draws the entire path I think, we really only need the portion that is visible
        
        
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
        points = (0...30).map{
            let x:CGFloat = 100*$0
            let y:CGFloat = (0..<(h*4)).random.cgFloat - (h.cgFloat * 3)
            return P(x,y)
        }
        
        let path:IPath = PolyLineGraphicUtils.path(points!)
        graphLine = contentContainer!.addSubView(GraphLine(width,height,path))
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

extension GraphView2{
    func addGraphPoint(){
        /*gp1*/
        let x:CGFloat = 0
        let p = findGraphP(x,points!)
        //Swift.print("addGraphPoint -p-: " + "\(p)")
        
        addGraphPointStyle()
        graphPoint1 = self.addSubView(Element(NaN,NaN,self,"graphPoint"))
        graphPoint1!.setPosition(p)
        /*gp2*/
        let x2:CGFloat = width
        let p2 = findGraphP(x2,points!)
        //Swift.print("addGraphPoint -p2-: " + "\(p2)")

        graphPoint2 = self.addSubView(Element(NaN,NaN,self,"graphPoint"))
        graphPoint2!.point = p2
        
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
        //Swift.print("findY x: " + "\(x)")
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
        //Swift.print("findY seg: " + "\(String(describing: seg))")
        let slope:CGFloat = CGPointParser.slope(seg!.p1, seg!.p2)
        //Swift.print("findY slope: " + "\(slope)")
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
