import Cocoa
@testable import Utils
@testable import Element

class GraphScrollView5:ElasticScrollerView5 {
    let points:[CGPoint]//you could bundle points in db, but then use DP2 it has generics
    var graphArea:GraphAreaKind

    lazy var animator:NumberSpringer = createAnimator()

    
    
    override func onEvent(_ event: Event) {
        super.onEvent(event)
        if event.type == AnimEvent.stopped {
            tick()
        }
    }
    override lazy var moverGroup: MoverGroup = {
        var group = MoverGroup(setProgress,self.maskSize,self.contentSize)
        group.event = (self as EventSendable).onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
        return group
    }()
    override var contentSize:CGSize {return CGSize(100.cgFloat * (graphArea.count-1),height)}
    //
    private var graphScrollerHandler:GraphScrollerHandler4 {return handler as! GraphScrollerHandler4}//move this to extension somewhere
    override lazy var handler:ProgressHandler = GraphScrollerHandler4(progressable:self)
    init(graphArea:GraphAreaKind, size: CGSize, id: String? = nil) {
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
        guard dir == .hor else {return}//this makes the scrolling go in only the x-axis
        //        Swift.print("setProgress")
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
        //        Swift.print("self.contentContainer.layer!.position: " + "\(self.contentContainer.layer!.position)")
        //        Swift.print("x: " + "\(x)")
        //        Swift.print("graphArea.count: " + "\(graphArea.count)")
        //        Swift.print("width: " + "\(width)")
        //        Swift.print("contentSize.width: " + "\(contentSize.width)")
        
        //Continue here: 🏀
        //make a method that returns points 👈
        
        let xVals = GraphScrollerHandler3.Utils.xValues(x: x, width: contentSize.width, itemWidth: 100, totCount: graphArea.count, visCount: 7)
        //        Swift.print("xVals: " + "\(xVals)")
        
        let vValues:[Int] = GraphScrollerHandler3.Utils.vValues(x: x, width: contentSize.width, itemWidth: 100, totCount: graphArea.count, visibleCount:7, itemAt: graphArea.item)
        //        Swift.print("vValues: " + "\(vValues)")
        //        let vValues:[CGFloat] = GraphUtils.randomVerticalValues(count:GraphX.config.totCount,min:0,max:140)
        let vVals:[CGFloat] = vValues.map{$0.cgFloat}
        let pts:[CGPoint] = GraphAreaX.points(vValues:vVals, size:CGSize(width,height))
        //        Swift.print("pts: " + "\(pts)")
        for (i,graphDot) in graphArea.graphDots.enumerated(){
            if let pt = pts[safe:i]{
                let xVal = xVals[i]
                graphDot.isHidden = false
                graphDot.layer?.position = CGPoint( xVal ,pt.y)
            }else{//dirty fix
                graphDot.isHidden = true
            }
        }
        
        /*updateGraphLine*/
        let graphLine = graphArea.graphLine
        let graphPoints:[CGPoint] = pts.indices.map{CGPoint(xVals[$0],pts[$0].y)}
        graphLine.line!.cgPath = CGPathParser.polyLine(graphPoints)//graphArea.graphDots.map{$0.layer!.position}
        graphLine.line!.draw()//draws the path
        
        ////        Swift.print("tick: x: \(x)")
        //        let minY = GraphScrollerHandler3.Utils.minY(x: x, width: width, points:graphArea.points,padding:00)
        ////        Swift.print("minY: " + "\(minY)")
        ////        Swift.print("self.prevMinY: " + "\(self.prevMinY)")
        //        if self.prevMinY != minY {/*Skips anim if the graph doesn't need to scale*/
        //            self.initAnim()/*Initiates the animation*/
        //        }else{
        ////            Swift.print("onFrame call")
        //            self.initAnim()
        //        }
        //        self.prevMinY = minY/*Set the prev anim*/
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}

extension GraphScrollView5{
    func createAnimator() -> NumberSpringer {
        //TODO:⚠️️ upgrade to latest anim lib, make create method
        let minY = GraphScrollerHandler3.Utils.minY(x:0, width:width, points:graphArea.points)
        let ratio:CGFloat = GraphScrollerHandler3.Utils.calcRatio(minY: minY, height: height)
        /*Setup interuptable animator*/
        let initValues:NumberSpringer.InitValues = (value:1,targetValue:ratio,velocity:0,stopVelocity:0)
        return  NumberSpringer(interpolateValue, initValues,NumberSpringer.initConfig)/*Anim*/
    }
}

class GraphScrollerHandler5:ElasticScrollerHandler5{
    override func onScrollWheelChange(_ event: NSEvent) {
        moverGroup.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup.updatePosition(true)/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p:CGPoint = moverGroup.result
        //        Swift.print("p: " + "\(p)")
        //        setProgress(p)
        progressable.contentContainer.layer?.position.x = p.x
    }
}
