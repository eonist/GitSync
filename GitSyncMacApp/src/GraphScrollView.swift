import Cocoa
@testable import Utils
@testable import Element

class GraphScrollView:ContainerView3,GraphScrollable{
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgressValue,self.maskSize,self.contentSize)
    override var maskSize:CGSize {return CGSize(super.getWidth(),super.getHeight())}/*Represents the visible part of the content *///TODO: could be ranmed to maskRect, say if you need x and y aswell
    override var contentSize:CGSize {return CGSize(100*19,super.getHeight())}
    var itemSize:CGSize {return CGSize(24,24)}
    var prevX:CGFloat = -100
    var prevPoints:[CGPoint]?/*Interim var*/
    var newPoints:[CGPoint]?
    var animator:Animator?/*Anim*/
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     * //TODO: ⚠️️ You need to make an scroolWheel method that you can override down hierarcy.
     */
    override func scrollWheel(with event:NSEvent) {//you can probably remove this method and do it in base?"!?
        //Swift.print("GraphAreaX.scrollWheel()")
        //(self as ICommitList).scroll(event)
        if(event.phase == NSEventPhase.changed){/*this is only direct manipulation, not momentum*/
            //Swift.print("moverGroup!.result.x: " + "\(moverGroup!.result.x)")
            frameTick()
        }
        super.scrollWheel(with:event)/*⚠️️, 👈 not good, forward the event other delegates higher up in the stack*/
    }
}
protocol GraphScrollable:ElasticScrollable3 {
    var prevX:CGFloat {get set}
    var points:[CGPoint]? {get set}
    var prevPoints:[CGPoint]? {get set}
    var newPoints:[CGPoint]? {get set}
    var animator:Animator? {get set}/*Anim*/
    
    //continue adding the tick variables to test the performance 🏀
}
extension GraphScrollable {
    var points:[CGPoint]? {get{return GraphAreaX.points}set{GraphAreaX.points = newValue}}
    /**
     * This method is fired on each "scrollWheel change event" and "MoverGroup setProgressValue call-back"
     */
    func frameTick(){
        //Swift.print("frameTick \(moverGroup!.result.x)")
        //find cur 0 to 1 progress
        /*let totWidth = contentSize.width
         let maskWidth = maskSize.width
         let availableSpace = totWidth - maskWidth*/
        let x = moverGroup!.result.x
        /*let progress = abs(x) / availableSpace
         Swift.print("progress: " + "\(progress)")*/
        /*print(ceil(334/100))
         print(ceil(300/100))*/
        
        /*
        let min:Int = ceil(abs(x)/100).int
        let right:CGFloat = abs(x)+(100*GraphX.config.vCount)
        let max:Int = floor(right/100).int
        
        let range:[CGFloat] = GraphAreaX.vValues!.slice2(min, max)
        
        let maxValue:CGFloat = range.max()!/*The max value in the current visible range*/
        _ = maxValue
        */
        
        //Swift.print("maxValue: " + "\(maxValue)")
        
        /*
        let size:CGSize = maskSize
        let points = GraphUtils.points(size, CGPoint(0,0), CGSize(100,100), range, maxValue,0,0)
        _ = points
        */
        
        let absX = abs(x)
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
    func tick(_ x:CGFloat){
        Swift.print("Tick: \(x)")
        
        let x1:CGFloat = -1 * x/*Here we flip the x to be positive*/
        let x2:CGFloat = (-1 * x) + width
        /**/
        let minX:CGFloat = x1/*The begining of the current visible graph*/
        let maxX:CGFloat = x2/*The end of the visible range*/
        let minY:CGFloat = self.minY(minX,maxX)/*Returns the smallest Y value in the visible range*/
        //Swift.print("⚠️️ minY: " + "\(minY))")
        
        //let dist:CGFloat = 400.cgFloat.distance(to: minY)
        let diff:CGFloat = height + (-1 * minY)/*Since graphs start from the bottom we need to flip the y coordinates*/
        //Swift.print("🍏 diff: " + "\(diff)")
        
        let ratio:CGFloat = height / diff/*Now that we have the flipped y coordinate we can get the ratio to scale all other points with */
        prevPoints = newPoints ?? (0...30).map{CGPoint($0*100,0)}//basically use newPoints if they exist or default points if not
        newPoints = points!.map{CGPointModifier.scale($0/*<--point to scale*/, CGPoint($0.x,height)/*<--pivot*/, CGPoint(1,ratio)/*<--Scalar ratio*/)}
        
        initAnim()/*initiates the animation*/
    }
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
    /**
     * Returns minY for the visible graph
     * NOTE: The visible graph is the portion of the graph that is visible at any given progression.
     * PARAM: minX: The begining of the current visible graph
     * PARAM: maxX: The end of the visible range
     */
    func minY(_ minX:CGFloat,_ maxX:CGFloat) -> CGFloat {
        let yValuesWithinMinXAndMaxX:[CGFloat] = points!.filter{$0.x >= minX && $0.x <= maxX}.map{$0.y}/*We gather the points within the current minX and maxX*/
        return (yValuesWithinMinXAndMaxX).min()!
    }
    /**
     * TODO: Comment this method
     */
    func setProgressValue(_ value:CGFloat, _ dir:Dir){/*gets called from MoverGroup*/
        if dir == .hor {
            //Swift.print("🍏 GraphScrollable.setProgressValue .hor: \(value)")
            frameTick()
            (self as ElasticScrollable3).setProgress(value, dir)
        }
    }
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent){/*Direct scroll*/
        //Swift.print("👻📜 (ElasticScrollable3).onScrollWheelChange : \(event.type) ")
        moverGroup!.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup!.updatePosition(true)/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p:CGPoint = moverGroup!.result
        setProgress(p)
    }
    func setProgress(_ point:CGPoint){
        //Swift.print("override setProgress")
        disableAnim {contentContainer.layer?.position = CGPoint(point.x,0)}
    }
}
