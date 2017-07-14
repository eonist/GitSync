import Cocoa
@testable import Element
@testable import Utils
/**
 * This tests 🗜 scaling the graph chart 📈 as you scroll  
 */
class GraphView2:ContainerView2{
    typealias P = CGPoint
    var points:[CGPoint]?//TODO: ⚠️️ This could probably be lazy
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
    var prevPoints:[CGPoint]?/*Interim var*/
    var newPoints:[CGPoint]?
    var animator:Animator?/*Anim*/
    
    override func resolveSkin() {
        StyleManager.addStyle("GraphView2{float:none;clear:none;fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        /*config*/
        points = createGraphCGPoints()/*Creates the init CGPoints that make up the Graph*/
        addGraphLine()
        addDebugEdgePoints()
        /*let minX:CGFloat = 0
         let maxX:CGFloat = self.width
         let minY:CGFloat = self.minY(minX,maxX)
         _ = minY*/
        //Swift.print("⚠️️ minY: " + "\(minY))")
        setProgress(0)/*init tick*/
    }
}
/*Animation*/
extension GraphView2{
    /**
     * This method is called when the user directly manipulates the scroll-wheel
     */
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
        contentContainer?.x = x
        
        let absX = abs(x)/*Force the x value to be possitive*/
        if absX >= prevX + 100 {/*only redraw at every 100px threshold*/
            Swift.print("if x:\(x)")
            tick(x)
            prevX = absX
        }else if absX < prevX{
            Swift.print("else if x: \(x)")
            tick(x)
            prevX = absX - 100
        }
    }
    /**
     * When the scroll hits threshold this method is called to adjust the GraphPoints in the y-coordinate-space to fit inside the view
     */
    func tick(_ x:CGFloat){
        //Swift.print("tick: x: \(x)")
        /*gp1*/
        let x1:CGFloat = -1 * x/*Here we flip the x to be positive*/
        let y1:CGFloat = findY(x1,points!)/*Here we find the y for x value via trig and finding the correct segment*/
        graphPoint1!.point = P(0,y1)//min edge
        /*gp2*/
        let x2:CGFloat = (-1 * x) + width
        let y2:CGFloat = findY(x2,points!)
        graphPoint2!.point = P(width,y2)//max edge
        edgeValues = (y1,y2)
        /**/
        let minX:CGFloat = x1/*The begining of the current visible graph*/
        let maxX:CGFloat = x2/*The end of the visible range*/
        let minY:CGFloat = self.minY(minX,maxX)/*Returns the smallest Y value in the visible range*/
        //Swift.print("⚠️️ minY: " + "\(minY))")
        
        //let dist:CGFloat = 400.cgFloat.distance(to: minY)
        let diff:CGFloat = height + (-1 * minY)/*Since graphs start from the bottom we need to flip the y coordinates*/
        //Swift.print("🍏 diff: " + "\(diff)")
        
        let ratio:CGFloat = height / diff/*Now that we have the flipped y coordinate we can get the ratio to scale all other points with */
        prevPoints = newPoints ?? (0...30).map{P($0*100,0)}//basically use newPoints if they exist or default points if not
        newPoints = points!.map{CGPointModifier.scale($0/*<--point to scale*/, P($0.x,height)/*<--pivot*/, P(1,ratio)/*<--Scalar ratio*/)}
        
        initAnim()/*initiates the animation*/
    }
}
extension GraphView2{
    /**
     * Initiates the animation sequence 
     * NOTE: this method can be called in quick sucession as it stops any ongoing animation before it is started
     */
    func initAnim(){
        if(animator != nil){animator!.stop()}/*Stop any previous running animation*/
        animator = Animator(Animation.sharedInstance,0.7,0,1,interpolateValue,Bounce.easeInOut)
        animator!.start()
        Swift.print("Start anim")
    }
    /**
     * Interpolates between 0 and 1 while the duration of the animation
     * NOTE: ReCalc the hValue indicators (each graph range has a different max hValue etc)
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
        //let path:IPath = PolyLineGraphicUtils.path(positions)/*Compiles a path that conceptually is a polyLine*/
        //graphLine!.line!.cgPath = CGPathUtils.compile(CGMutablePath(), path)/*Converts the path to a cgPath*/
        graphLine!.line!.cgPath = CGPathParser.polyLine(positions)
        disableAnim{
            graphLine!.line!.draw() /*draws the path*///TODO: ⚠️️ it draws the entire path I think, we really only need the portion that is visible
        }
    }
}
/**
 * Create graph elements
 */
extension GraphView2{
    /**
     * Returns CGPoint's that represents the Graph
     * NOTE: Returns random y-values and evenly spaced x-values at every 100th pixel
     */
    func createGraphCGPoints() -> [P] {
        let h:Int = height.int
        return (0...30).map{
            let x:CGFloat = 100*$0/*Evenly place points at every 100th pixel*/
            let y:CGFloat = (0..<(h*4)).random.cgFloat - (h.cgFloat * 3)/*Randomly set the Y coordinate within 0 and height*///TODO: ⚠️️ this could be simplified by not doing the multipliations
            return P(x,y)
        }
    }
    /**
     * Creates the GraphLines
     */
    func addGraphLine(){
        addGraphLineStyle()
        let path:IPath = Path()
        graphLine = contentContainer!.addSubView(GraphLine(width,height,path))
    }
    
    /**
     * Adds graphical representations of the begining and end of the graphline
     * NOTE: These are used to display exactly the edges of the graph line. Beginning and end
     */
    func addDebugEdgePoints(){
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
}
/**
 * Utilitiy methods
 */
extension GraphView2{
    /**
     * Returns minY for the visible graph
     * NOTE: The visible graph is the portion of the graph that is visible at any given progression.
     * PARAM: minX: The begining of the current visible graph
     * PARAM: maxX: The end of the visible range
     */
    func minY(_ minX:CGFloat,_ maxX:CGFloat) -> CGFloat {
        let yValuesWithinMinXAndMaxX:[CGFloat] = points!.filter{$0.x >= minX && $0.x <= maxX}.map{$0.y}/*We gather the points within the current minX and maxX*/
        return ([edgeValues!.start, edgeValues!.end] + yValuesWithinMinXAndMaxX).min()!
    }
    /**
     * Returns a GraphCGPoint for PARAM: x value
     * PARAM: points: We need the points in order to find the correct segment to calc the y value. (Uses trig equation slope)
     */
    func findGraphP(_ x:CGFloat, _ points:[P]) -> P{
        let y:CGFloat = findY(x,points)
        return P(x,y)
    }
    /**
     * Returns Y for X by finding the correct segment and then finally using trig to calculate the y for x
     */
    func findY(_ x:CGFloat, _ points:[P])->CGFloat{
        //Swift.print("findY x: " + "\(x)")
        var seg:(p1:P,p2:P)?
        for i in 0..<points.count-1{
            let cur = points[i]
            let next = points[i+1]
            if(x >= cur.x && x <= next.x){/*within*/
                seg = (cur,next)
                break
            }
        }
        //seg = seg ?? (points[points.count-2],points.last!)
        //Swift.print("findY seg: " + "\(String(describing: seg))")
        let slope:CGFloat = CGPointParser.slope(seg!.p1, seg!.p2)/*Calculates the slope between two points*/
        //Swift.print("findY slope: " + "\(slope)")
        let y:CGFloat = CGPointParser.y(seg!.p1, x, slope)/*seg!.p2.x*/
        return y
    }
}
/**
 * Adds the styles used in the graph
 */
extension GraphView2{
    /**
     * Adds the GraphLine style
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
