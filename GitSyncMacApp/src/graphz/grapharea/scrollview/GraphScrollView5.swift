import Cocoa
@testable import Utils
@testable import Element

class GraphScrollView5:ElasticScrollerView5 {
    var graphArea:GraphAreaZ
    var prevX:CGFloat = 0//used for modulo ticking
//    var prevMinY:CGFloat?//prevMinY to avoid calling start anim
    var curPts:[CGPoint] {get{return graphArea.points} set{graphArea.points = newValue}}
    //
    lazy var animator:NumberSpringer = {return createAnimator()}()
    override lazy var moverGroup: MoverGroup = {return createMoverGroup()}()
    //
    override var contentSize:CGSize {return CGSize(100.cgFloat * (graphArea.count),height)}
    private var graphScrollerHandler:GraphScrollerHandler5 {return handler as! GraphScrollerHandler5}//move this to extension somewhere
    override lazy var handler:ProgressHandler = GraphScrollerHandler5(progressable:self)
    
    init(graphArea:GraphAreaZ, size: CGSize, id: String? = nil) {
        //Swift.print("size: " + "\(size)")
        self.graphArea = graphArea
        super.init(size: size, id: id)
    }
    override func resolveSkin() {
        StyleManager.addStyle("ContainerView{fill:blue;fill-alpha:0.5;}")
        super.resolveSkin()
    }
    override func setProgress(_ progress: CGFloat, _ dir: Dir) {
        guard dir == .hor else {return}//this makes the scrolling go in only the x-axis
        self.contentContainer.layer?.position[dir] = progress
        frameTick()
    }
    override open func scrollWheel(with event: NSEvent) {
        super.scrollWheel(with: event)
        frameTick()
    }
    func frameTick() {
        let x = self.contentContainer.layer!.position.x.clip(-(contentSize.w-width), 0)//x pos of scrolling container,we use the x value as if elastic doesn't exist 👌
        let absX = abs(x)
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
    private func tick(){
//        Swift.print("tick")
        let x = self.contentContainer.layer!.position.x.clip(-(contentSize.w-width), 0)//we use the x value as if elastic doesnt exist 👌
        let maxValue:Int = graphArea.maxCommitCount
        curPts = GraphZUtils.points(rect: CGRect(0,0,width,height), spacing: CGSize(100,100), xProgress: x, totContentWidth: contentSize.width, totCount: graphArea.count, visibleCount: graphArea.visibleCount, itemAt: graphArea.item, maxValue:maxValue)
        self.initAnim()
    }
    /**
     * EcentHandler
     */
    override func onEvent(_ event: Event) {
        super.onEvent(event)
        if event.type == AnimEvent.stopped {
//            tick()
        }
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
//creators
extension GraphScrollView5{
    func createAnimator() -> NumberSpringer {
//        Swift.print("createAnimator")
        //TODO:⚠️️ upgrade to latest anim lib, make create method
        let minY = GraphZUtils.minY(pts: curPts)
        let ratio:CGFloat = GraphScrollerHandler3.Utils.calcRatio(minY: minY, height: height)
//        Swift.print("ratio: " + "\(ratio)")
        /*Setup interuptable animator*/
        let initValues:NumberSpringer.InitValues = (value:ratio,targetValue:ratio,velocity:0,stopVelocity:0)
        return NumberSpringer(interpolateVal, initValues, NumberSpringer.initConfig)/*Anim*/
    }
    func createMoverGroup()->MoverGroup{
        var group = MoverGroup(setProgress,self.maskSize,self.contentSize)
        group.event = (self as EventSendable).onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
        return group
    }
}
