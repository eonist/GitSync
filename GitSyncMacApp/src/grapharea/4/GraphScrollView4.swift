import Cocoa
@testable import Utils
@testable import Element

//Continue here: 🏀
    //The ScrollView5 isn't moving, try the test from archive and figure out whats wrong ✅
    //If it works then try adding the bouncy animation  ✅
    //clip the progress to .hor only ✅
    //then add elastic ✅
    //try solving why the first point isnt scaled 🚫
        //this can be solved by adding animate on moveGroup complete etc
    //Then try using DP2 👈
        //try adding more count first ✅
    //try using more extreme values ✅
    //scale on init
    //find a better way to to calc the minY ✅
    //avoid the orphan graph point at the end ✅
    //Then try pinching in and out of levels
    //then try adding visual feedback when pinching
    

class GraphScrollView4:ElasticScrollerView5 {//ScrollerView5
//    let points:[CGPoint]//you could bundle points in db, but then use DP2 it has generics
    var graphArea:GraphAreaX
    var prevX:CGFloat = -150
    var prevMinY:CGFloat?//prevMinY to avoid calling start anim
    
    lazy var animator:NumberSpringer = {//TODO:⚠️️ upgrade to latest anim lib
        let minY = GraphScrollerHandler3.Utils.minY(x:0, width:width, points:graphArea.points)
        let ratio:CGFloat = GraphScrollerHandler3.Utils.calcRatio(minY: minY, height: height)
//        Swift.print("ratio: " + "\(ratio)")
        /*Setup interuptable animator*/
        let initValues:NumberSpringer.InitValues = (value:1,targetValue:ratio,velocity:0,stopVelocity:0)
        return  NumberSpringer(interpolateValue, initValues,NumberSpringer.initConfig)/*Anim*/
    }()
    override func onEvent(_ event: Event) {
        super.onEvent(event)
        
        Swift.print("event.type: " + "\(event.type)")
        if event.type == AnimEvent.stopped {
            Swift.print("complete")
            tick()
        }
    }
    //
    override lazy var moverGroup: MoverGroup = {
        var group = MoverGroup(setProgress,self.maskSize,self.contentSize)
        group.event = (self as EventSendable).onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
        return group
    }()
    override var contentSize:CGSize {return CGSize(100.cgFloat * (GraphX.config.totCount-1),height)}
    //
    private var graphScrollerHandler:GraphScrollerHandler4 {return handler as! GraphScrollerHandler4}//move this to extension somewhere
    override lazy var handler:ProgressHandler = GraphScrollerHandler4(progressable:self)
    
    init(graphArea:GraphAreaX, size: CGSize, id: String? = nil) {
//        Swift.print("size: " + "\(size)")
        self.graphArea = graphArea
        super.init(size: size, id: id)
    }
    override func resolveSkin() {
        StyleManager.addStyle("ContainerView{fill:blue;fill-alpha:0.5;}")
//        Swift.print("-(contentSize.w-width): " + "\(-(contentSize.w-width))")
        super.resolveSkin()
    }
    override func setProgress(_ progress: CGFloat, _ dir: Dir) {
//        guard dir == .hor else {return}
        self.contentContainer.layer?.position[dir] = progress
        frameTick()
    }
    override open func scrollWheel(with event: NSEvent) {
        super.scrollWheel(with: event)
//        Swift.print("self.contentContainer.layer!.position.x: " + "\(self.contentContainer.layer!.position.x)")
        frameTick()
    }
    func frameTick() {
        let x = self.contentContainer.layer!.position.x.clip(-(contentSize.w-width), 0)
//        Swift.print("frameTick x: \(x)")
        let absX = abs(x)
//        Swift.print("absX: " + "\(absX)")
//        Swift.print("prevX: " + "\(prevX)")
        if absX >= prevX + 100 {/*only redraw at every 100px threshold*/
            tick()
            prevX = absX
        }else if absX < prevX{
            tick()
            prevX = absX - 100
        }
    }
    /**
     * This method is only called on every 100th px threshold
     */
    private func tick(/*_ x:CGFloat*/){
        //Bouncy anim
        let x = self.contentContainer.layer!.position.x.clip(-(contentSize.w-width), 0)//we use the x value as if elastic doesnt exist 👌
//        Swift.print("tick: x: \(x)")
        let minY = GraphScrollerHandler3.Utils.minY(x: x, width: width, points:graphArea.points,padding:00)
//        Swift.print("minY: " + "\(minY)")
//        Swift.print("self.prevMinY: " + "\(self.prevMinY)")
        if self.prevMinY != minY {/*Skips anim if the graph doesn't need to scale*/
            self.initAnim()/*Initiates the animation*/
        }else{
//            Swift.print("onFrame call")
            self.initAnim()
        }
        self.prevMinY = minY/*Set the prev anim*/
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension GraphScrollView4{
    /**
     * Initiates the animation sequence
     * NOTE: this method can be called in quick sucession as it stops any ongoing animation before it is started
     */
    func initAnim(){
        let x = self.contentContainer.layer!.position.x.clip(-(contentSize.w-width), 0)
//        Swift.print("moverGroup.result.x: " + "\(moverGroup.result.x)")
        let minY = GraphScrollerHandler3.Utils.minY(x:x, width:width, points:graphArea.points,padding:00)
//        let pts:[CGPoint] = GraphScrollerHandler3.Utils.calcPointsWithin(x: x, width: width, points: graphArea.points,padding: 00)
//        Swift.print("pts.first: " + "\(pts.first)")
//        Swift.print("pts.last: " + "\(pts.last)")
//        Swift.print("x: " + "\(x)")
        //let x:CGFloat = moverGroup.result.x
        let ratio:CGFloat = GraphScrollerHandler3.Utils.calcRatio(minY: minY, height: height)
        animator.targetValue = ratio
        if animator.stopped {animator.start()}
    }
    /**
     * Interpolates between 0 and 1 while the duration of the animation
     * NOTE: ReCalc the hValue indicators (each graph range has a different max hValue etc)
     */
    private func interpolateValue(_ val:CGFloat){
        //let x = moverGroup.result.x
        let x = self.contentContainer.layer!.position.x.clip(-(contentSize.w-width), 0)
//        Swift.print("x: " + "\(x)")
        let pts:[CGPoint] = GraphScrollerHandler3.Utils.calcPointsWithin(x: x, width: width, points: graphArea.points,padding: 200)
        let scaledPts:[CGPoint] = GraphScrollerHandler3.Utils.calcScaledPoints(points: pts, ratio: val, height: height)
        /*GraphPoints*/
        for (i,graphDot) in graphArea.graphDots.enumerated(){
            if let pt = scaledPts[safe:i]{
                graphDot.isHidden = false
                graphDot.layer?.position = pt//CGPoint(0,pt.y)
            }else{//dirty fix
                graphDot.isHidden = true
            }
        }
        /*updateGraphLine*/
        let graphLine = graphArea.graphLine
        graphLine.line!.cgPath = CGPathParser.polyLine(scaledPts)//graphArea.graphDots.map{$0.layer!.position}
        graphLine.line!.draw()//draws the path
    }
}
class GraphScrollerHandler4:ElasticScrollerHandler5{
    
    override func onScrollWheelChange(_ event: NSEvent) {
        moverGroup.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup.updatePosition(true)/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p:CGPoint = moverGroup.result
        //        Swift.print("p: " + "\(p)")
        //        setProgress(p)
        progressable.contentContainer.layer?.position.x = p.x
    }
}
